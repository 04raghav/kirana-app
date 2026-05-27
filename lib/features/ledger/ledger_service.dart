import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final ledgerServiceProvider = Provider<LedgerService>((ref) {
  return LedgerService(ref.watch(databaseProvider));
});

class LedgerService {
  final AppDatabase _db;

  LedgerService(this._db);

  Future<List<Ledger>> getLedgersByTypeAndDate(String type) async {
    return (_db.select(
      _db.ledgers,
    )..where((t) => t.ledgerType.equals(type))).get();
  }

  Future<List<Ledger>> getLedgersForDate(DateTime date, String type) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final allOfType =
        await (_db.select(_db.ledgers)
              ..where((t) => t.ledgerType.equals(type))
              ..orderBy([
                (t) =>
                    OrderingTerm(expression: t.date, mode: OrderingMode.desc),
              ]))
            .get();

    return allOfType
        .where((l) => !l.date.isBefore(start) && l.date.isBefore(end))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getLedgerBreakup(int ledgerId) async {
    final ledger = await (_db.select(
      _db.ledgers,
    )..where((t) => t.id.equals(ledgerId))).getSingleOrNull();
    if (ledger == null) return [];

    if (ledger.ledgerType == 'purchase' && ledger.partyType == 'wholesaler') {
      // Breakdown: items purchased from this wholesaler (via purchase sources)
      final rows = await _db
          .customSelect(
            '''
        SELECT bis.id as bill_item_source_id,
               ips.id as purchase_source_id,
               w.id as wholesaler_id,
               w.name as wholesaler_name,
               i.id as item_id,
               i.name as item_name,
               rbi.quantity as quantity,
               bis.purchase_price_at_time as purchase_price_at_time,
               rb.id as bill_id,
               rb.date as bill_date
        FROM bill_item_sources bis
        JOIN item_purchase_sources ips ON ips.id = bis.purchase_source_id
        JOIN wholesalers w ON w.id = ips.wholesaler_id
        JOIN retailer_bill_items rbi ON rbi.id = bis.bill_item_id
        JOIN items i ON i.id = rbi.item_id
        JOIN retailer_bills rb ON rb.id = rbi.bill_id
        WHERE ips.wholesaler_id = :wholesalerId
        ORDER BY rb.date DESC
      ''',
            variables: [Variable<int>(ledger.partyId)],
          )
          .get();

      return rows.map((r) => r.data).toList();
    }

    if (ledger.ledgerType == 'sale' && ledger.partyType == 'retailer') {
      // Breakdown: items sold to this retailer
      final rows = await _db
          .customSelect(
            '''
        SELECT rbi.id as bill_item_id,
               rb.id as bill_id,
               rb.date as bill_date,
               r.id as retailer_id,
               r.name as retailer_name,
               i.id as item_id,
               i.name as item_name,
               rbi.quantity as quantity,
               rbi.selling_price as selling_price,
               bis.purchase_price_at_time as purchase_price_at_time,
               bis.purchase_source_id as purchase_source_id
        FROM retailer_bill_items rbi
        JOIN retailer_bills rb ON rb.id = rbi.bill_id
        JOIN retailers r ON r.id = rb.retailer_id
        JOIN items i ON i.id = rbi.item_id
        LEFT JOIN bill_item_sources bis ON bis.bill_item_id = rbi.id
        WHERE rb.retailer_id = :retailerId
        ORDER BY rb.date DESC
      ''',
            variables: [Variable<int>(ledger.partyId)],
          )
          .get();

      return rows.map((r) => r.data).toList();
    }

    // Default: return empty
    return [];
  }

  /// Return migration verification counts to help confirm conversion.
  Future<Map<String, int>> getMigrationReport() async {
    final totalLegacy =
        (await _db
                    .customSelect(
                      'SELECT COUNT(*) as c FROM wholesaler_inventory',
                    )
                    .get())
                .first
                .data['c']
            as int? ??
        0;
    final converted =
        (await _db
                    .customSelect(
                      'SELECT COUNT(*) as c FROM item_purchase_sources WHERE original_inventory_id IS NOT NULL',
                    )
                    .get())
                .first
                .data['c']
            as int? ??
        0;
    final bisWithSource =
        (await _db
                    .customSelect(
                      'SELECT COUNT(*) as c FROM bill_item_sources WHERE purchase_source_id IS NOT NULL',
                    )
                    .get())
                .first
                .data['c']
            as int? ??
        0;
    final bisWithInventory =
        (await _db
                    .customSelect(
                      'SELECT COUNT(*) as c FROM bill_item_sources WHERE inventory_id IS NOT NULL',
                    )
                    .get())
                .first
                .data['c']
            as int? ??
        0;

    return {
      'legacy_wholesaler_inventory_rows': totalLegacy,
      'converted_purchase_sources': converted,
      'bill_item_sources_with_purchase_source': bisWithSource,
      'bill_item_sources_with_inventory': bisWithInventory,
    };
  }

  Future<void> applyPayment({
    required int ledgerId,
    required double amount,
    required String paymentMode,
    bool isFullPayment = false,
  }) async {
    await _db.transaction(() async {
      await _db
          .into(_db.payments)
          .insert(
            PaymentsCompanion(
              ledgerId: Value(ledgerId),
              amount: Value(amount),
              paymentMode: Value(paymentMode),
              isFullPayment: Value(isFullPayment),
            ),
          );

      // update ledger totals
      final ledger = await (_db.select(
        _db.ledgers,
      )..where((t) => t.id.equals(ledgerId))).getSingle();
      final newAmountPaid = ledger.amountPaid + amount;
      final newRemaining = ledger.totalAmount - newAmountPaid;
      await (_db.update(
        _db.ledgers,
      )..where((t) => t.id.equals(ledgerId))).write(
        LedgersCompanion(
          amountPaid: Value(newAmountPaid),
          remainingAmount: Value(newRemaining < 0 ? 0.0 : newRemaining),
          isFullyPaid: Value(isFullPayment || newRemaining <= 0),
        ),
      );
    });
  }
}

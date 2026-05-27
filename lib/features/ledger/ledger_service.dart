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

  Future<Ledger?> getLedgerById(int ledgerId) async {
    return (_db.select(
      _db.ledgers,
    )..where((t) => t.id.equals(ledgerId))).getSingleOrNull();
  }

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
    final ledger = await getLedgerById(ledgerId);
    if (ledger == null) return [];

    final start = DateTime(
      ledger.date.year,
      ledger.date.month,
      ledger.date.day,
    );
    final end = start.add(const Duration(days: 1));

    if (ledger.ledgerType == 'purchase' && ledger.partyType == 'wholesaler') {
      final rows = await _db
          .customSelect(
            '''
        SELECT rb.id as bill_id,
               rb.date as bill_date,
               rb.total_amount as bill_total_amount,
               rb.tax_amount as bill_tax_amount,
               rb.bardana_amount as bill_bardana_amount,
               rbi.id as bill_item_id,
               i.id as item_id,
               i.name as item_name,
               rbi.quantity as quantity,
               rbi.selling_price as selling_price,
               rbi.gst_rate as gst_rate,
               rbi.bardana as bardana,
               bis.id as bill_item_source_id,
               bis.purchase_source_id as purchase_source_id,
               bis.inventory_id as inventory_id,
               bis.purchase_price_at_time as purchase_price_at_time,
               COALESCE(ips.wholesaler_id, wi.wholesaler_id) as wholesaler_id,
               COALESCE(w.name, 'Unknown wholesaler') as wholesaler_name
        FROM retailer_bills rb
        JOIN retailer_bill_items rbi ON rbi.bill_id = rb.id
        JOIN items i ON i.id = rbi.item_id
        LEFT JOIN bill_item_sources bis ON bis.bill_item_id = rbi.id
        LEFT JOIN item_purchase_sources ips ON ips.id = bis.purchase_source_id
        LEFT JOIN wholesaler_inventory wi ON wi.id = bis.inventory_id
        LEFT JOIN wholesalers w ON w.id = COALESCE(ips.wholesaler_id, wi.wholesaler_id)
        WHERE rb.date >= :startDate
          AND rb.date < :endDate
          AND COALESCE(ips.wholesaler_id, wi.wholesaler_id) = :partyId
        ORDER BY rb.date DESC, rb.id DESC, rbi.id ASC
      ''',
            variables: [
              Variable<DateTime>(start),
              Variable<DateTime>(end),
              Variable<int>(ledger.partyId),
            ],
          )
          .get();

      return rows.map((r) => r.data).toList();
    }

    if (ledger.ledgerType == 'sale' && ledger.partyType == 'retailer') {
      final rows = await _db
          .customSelect(
            '''
        SELECT rb.id as bill_id,
               rb.date as bill_date,
               rb.total_amount as bill_total_amount,
               rb.tax_amount as bill_tax_amount,
               rb.bardana_amount as bill_bardana_amount,
               rbi.id as bill_item_id,
               i.id as item_id,
               i.name as item_name,
               rbi.quantity as quantity,
               rbi.selling_price as selling_price,
               rbi.gst_rate as gst_rate,
               rbi.bardana as bardana,
               bis.id as bill_item_source_id,
               bis.purchase_source_id as purchase_source_id,
               bis.inventory_id as inventory_id,
               bis.purchase_price_at_time as purchase_price_at_time,
               COALESCE(ips.wholesaler_id, wi.wholesaler_id) as wholesaler_id,
               COALESCE(w.name, 'Unknown wholesaler') as wholesaler_name
        FROM retailer_bills rb
        JOIN retailer_bill_items rbi ON rbi.bill_id = rb.id
        JOIN items i ON i.id = rbi.item_id
        LEFT JOIN bill_item_sources bis ON bis.bill_item_id = rbi.id
        LEFT JOIN item_purchase_sources ips ON ips.id = bis.purchase_source_id
        LEFT JOIN wholesaler_inventory wi ON wi.id = bis.inventory_id
        LEFT JOIN wholesalers w ON w.id = COALESCE(ips.wholesaler_id, wi.wholesaler_id)
        WHERE rb.date >= :startDate
          AND rb.date < :endDate
          AND rb.retailer_id = :partyId
        ORDER BY rb.date DESC, rb.id DESC, rbi.id ASC
      ''',
            variables: [
              Variable<DateTime>(start),
              Variable<DateTime>(end),
              Variable<int>(ledger.partyId),
            ],
          )
          .get();

      return rows.map((r) => r.data).toList();
    }

    // Default: return empty
    return [];
  }

  Future<List<Payment>> getPaymentsForLedger(int ledgerId) async {
    return (_db.select(_db.payments)
          ..where((t) => t.ledgerId.equals(ledgerId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .get();
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
    DateTime? paymentDate,
    String? note,
    bool isFullPayment = false,
  }) async {
    await _db.transaction(() async {
      final ledger = await (_db.select(
        _db.ledgers,
      )..where((t) => t.id.equals(ledgerId))).getSingle();

      final normalizedAmount = isFullPayment ? ledger.remainingAmount : amount;
      final cappedAmount = normalizedAmount.clamp(0.0, ledger.remainingAmount);
      final newAmountPaid = (ledger.amountPaid + cappedAmount).clamp(
        0.0,
        ledger.totalAmount,
      );
      final newRemaining = ledger.totalAmount - newAmountPaid;

      await _db
          .into(_db.payments)
          .insert(
            PaymentsCompanion(
              ledgerId: Value(ledgerId),
              amount: Value(cappedAmount),
              paymentMode: Value(paymentMode),
              date: Value(paymentDate ?? DateTime.now()),
              note: Value(note),
              isFullPayment: Value(isFullPayment || newRemaining <= 0),
            ),
          );

      await (_db.update(
        _db.ledgers,
      )..where((t) => t.id.equals(ledgerId))).write(
        LedgersCompanion(
          amountPaid: Value(newAmountPaid),
          remainingAmount: Value(newRemaining < 0 ? 0.0 : newRemaining),
          paymentMode: Value(paymentMode),
          isFullyPaid: Value(isFullPayment || newRemaining <= 0),
        ),
      );
    });
  }
}

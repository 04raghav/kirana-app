import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final billingServiceProvider = Provider<BillingService>((ref) {
  return BillingService(ref.watch(databaseProvider));
});

class BillItemRequest {
  final int itemId;
  final double quantity;
  final double sellingPrice;
  final double gstRate;
  final double bardana;
  final int? purchaseSourceId; // new: selected wholesaler source id

  BillItemRequest({
    required this.itemId,
    required this.quantity,
    required this.sellingPrice,
    required this.gstRate,
    required this.bardana,
    this.purchaseSourceId,
  });
}

class BillingService {
  final AppDatabase _db;

  BillingService(this._db);

  /// Generates a retailer bill and reduces inventory using FIFO from wholesalers
  Future<int> generateRetailerBill({
    required int retailerId,
    required List<BillItemRequest> items,
  }) async {
    return await _db.transaction(() async {
      double totalAmount = 0;
      double totalTax = 0;
      double totalBardana = 0;
      // aggregates for purchase ledger per wholesaler
      final Map<int, double> wholesalerPurchaseSums = {};

      // 1. Create empty bill first
      final billId = await _db
          .into(_db.retailerBills)
          .insert(
            RetailerBillsCompanion.insert(
              retailerId: retailerId,
              totalAmount: 0.0,
            ),
          );

      // 2. Process each item using selected purchase source
      for (final req in items) {
        // Add bill item
        final billItemId = await _db
            .into(_db.retailerBillItems)
            .insert(
              RetailerBillItemsCompanion.insert(
                billId: billId,
                itemId: req.itemId,
                quantity: req.quantity,
                sellingPrice: req.sellingPrice,
                gstRate: req.gstRate,
                bardana: req.bardana,
              ),
            );

        // Resolve purchase source
        int? purchaseSourceId = req.purchaseSourceId;
        double purchasePriceSnapshot = 0.0;
        int? wholesalerIdForLedger;

        if (purchaseSourceId != null) {
          final src = await (_db.select(
            _db.itemPurchaseSources,
          )..where((t) => t.id.equals(purchaseSourceId))).getSingleOrNull();
          if (src == null) {
            throw Exception('Selected purchase source not found');
          }

          purchasePriceSnapshot = src.purchasePrice;
          wholesalerIdForLedger = src.wholesalerId;

          final legacyInventoryId =
              src.originalInventoryId ??
              await _createLegacyInventoryMirror(
                itemId: req.itemId,
                wholesalerId: src.wholesalerId,
                purchasePrice: src.purchasePrice,
                bardana: src.bardana,
                quantity: req.quantity,
              );

          // If source maintains quantity and is not N/A, ensure availability and deduct
          if (!src.isQuantityNa) {
            final available = src.quantity ?? 0.0;
            if (available < req.quantity) {
              throw Exception(
                'Insufficient stock from selected wholesaler for item id ${req.itemId}',
              );
            }

            // update source quantity
            await (_db.update(
              _db.itemPurchaseSources,
            )..where((t) => t.id.equals(src.id))).write(
              ItemPurchaseSourcesCompanion(
                quantity: Value(available - req.quantity),
              ),
            );
          }

          // Log BillItemSources mapping to purchase source
          await _db
              .into(_db.billItemSources)
              .insert(
                BillItemSourcesCompanion.insert(
                  billItemId: billItemId,
                  inventoryId: Value(legacyInventoryId),
                  purchaseSourceId: Value(purchaseSourceId),
                  quantityAllocated: req.quantity,
                  purchasePriceAtTime: purchasePriceSnapshot,
                ),
              );
        } else {
          // No purchase source selected: fall back to legacy FIFO using wholesalerInventory
          double remainingQty = req.quantity;
          final inventoryList =
              await (_db.select(_db.wholesalerInventory)
                    ..where((tbl) => tbl.itemId.equals(req.itemId))
                    ..where((tbl) => tbl.quantityToSell.isBiggerThanValue(0))
                    ..orderBy([(t) => OrderingTerm(expression: t.receivedAt)]))
                  .get();

          final totalAvailable = inventoryList.fold<double>(
            0,
            (s, i) => s + i.quantityToSell,
          );
          if (totalAvailable < remainingQty) {
            final item = await (_db.select(
              _db.items,
            )..where((t) => t.id.equals(req.itemId))).getSingle();
            throw Exception(
              'Insufficient stock for ${item.name} (Available: $totalAvailable, Required: $remainingQty)',
            );
          }

          for (var inv in inventoryList) {
            if (remainingQty <= 0) break;
            final allocateQty = (inv.quantityToSell >= remainingQty)
                ? remainingQty
                : inv.quantityToSell;

            // Deduct from inventory
            await (_db.update(
              _db.wholesalerInventory,
            )..where((tbl) => tbl.id.equals(inv.id))).write(
              WholesalerInventoryCompanion(
                quantityToSell: Value(inv.quantityToSell - allocateQty),
              ),
            );

            await _db
                .into(_db.billItemSources)
                .insert(
                  BillItemSourcesCompanion.insert(
                    billItemId: billItemId,
                    inventoryId: Value(inv.id),
                    purchaseSourceId: Value.absent(),
                    quantityAllocated: allocateQty,
                    purchasePriceAtTime: inv.purchasePrice,
                  ),
                );

            wholesalerIdForLedger = inv.wholesalerId;
            wholesalerPurchaseSums[inv.wholesalerId] =
                (wholesalerPurchaseSums[inv.wholesalerId] ?? 0.0) +
                (allocateQty * inv.purchasePrice);

            remainingQty -= allocateQty;
          }
        }

        // Internal transactions log (sale out)
        await _db
            .into(_db.inventoryTransactions)
            .insert(
              InventoryTransactionsCompanion.insert(
                itemId: req.itemId,
                retailerId: Value(retailerId),
                type: 'OUT',
                quantity: req.quantity,
                referenceId: Value('BILL_\$billId'),
              ),
            );

        // Calculate amounts
        final itemTotal = (req.quantity * req.sellingPrice);
        final tax = itemTotal * (req.gstRate / 100);

        totalAmount += itemTotal + tax + req.bardana;
        totalTax += tax;
        totalBardana += req.bardana;

        // Aggregate purchase sums when purchaseSourceId path used
        if (req.purchaseSourceId != null && wholesalerIdForLedger != null) {
          wholesalerPurchaseSums[wholesalerIdForLedger] =
              (wholesalerPurchaseSums[wholesalerIdForLedger] ?? 0.0) +
              (req.quantity * purchasePriceSnapshot);
        }
      }

      // Update bill with final amounts
      await (_db.update(
        _db.retailerBills,
      )..where((t) => t.id.equals(billId))).write(
        RetailerBillsCompanion(
          totalAmount: Value(totalAmount),
          taxAmount: Value(totalTax),
          bardanaAmount: Value(totalBardana),
        ),
      );

      // Create sales ledger for retailer
      await _db
          .into(_db.ledgers)
          .insert(
            LedgersCompanion(
              ledgerType: Value('sale'),
              partyType: Value('retailer'),
              partyId: Value(retailerId),
              totalAmount: Value(totalAmount),
              amountPaid: Value(0.0),
              remainingAmount: Value(totalAmount),
              interest: Value(0.0),
              paymentMode: const Value.absent(),
              isFullyPaid: Value(false),
            ),
          );

      // Create purchase ledgers per wholesaler
      for (final entry in wholesalerPurchaseSums.entries) {
        final wholesalerId = entry.key;
        final amt = entry.value;
        await _db
            .into(_db.ledgers)
            .insert(
              LedgersCompanion(
                ledgerType: Value('purchase'),
                partyType: Value('wholesaler'),
                partyId: Value(wholesalerId),
                totalAmount: Value(amt),
                amountPaid: Value(0.0),
                remainingAmount: Value(amt),
                interest: Value(0.0),
                paymentMode: const Value.absent(),
                isFullyPaid: Value(false),
              ),
            );
      }

      return billId;
    });
  }

  Future<int> _createLegacyInventoryMirror({
    required int itemId,
    required int wholesalerId,
    required double purchasePrice,
    required double bardana,
    required double quantity,
  }) {
    return _db
        .into(_db.wholesalerInventory)
        .insert(
          WholesalerInventoryCompanion.insert(
            itemId: itemId,
            wholesalerId: wholesalerId,
            quantityToSell: quantity,
            purchasePrice: purchasePrice,
            bardana: Value(bardana),
          ),
        );
  }
}

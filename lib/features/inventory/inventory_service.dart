import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final inventoryServiceProvider = Provider<InventoryService>((ref) {
  return InventoryService(ref.watch(databaseProvider));
});

class InventoryService {
  final AppDatabase _db;

  InventoryService(this._db);

  /// Add inward inventory from a wholesaler
  Future<void> addInwardInventory({
    required int itemId,
    required int wholesalerId,
    required double quantity,
    required double purchasePrice,
    required double bardana,
    String? referenceId,
  }) async {
    await _db.transaction(() async {
      // 1. Create/Update ItemPurchaseSources entry (new purchase source)
      await _db
          .into(_db.itemPurchaseSources)
          .insert(
            ItemPurchaseSourcesCompanion(
              itemId: Value(itemId),
              wholesalerId: Value(wholesalerId),
              purchasePrice: Value(purchasePrice),
              gstRate: Value(0.0),
              bardana: Value(bardana),
              quantity: Value(quantity),
              isQuantityNa: Value(false),
            ),
          );

      // 2. Log transaction for record (IN)
      await _db
          .into(_db.inventoryTransactions)
          .insert(
            InventoryTransactionsCompanion(
              itemId: Value(itemId),
              wholesalerId: Value(wholesalerId),
              type: Value('IN'),
              quantity: Value(quantity),
              referenceId: Value(referenceId),
            ),
          );
    });
  }

  /// Get available inventory aggregated by item
  Future<List<Map<String, dynamic>>> getAvailableStock() async {
    // Aggregate quantities from ItemPurchaseSources where quantity is applicable
    final query = _db.select(_db.itemPurchaseSources).join([
      innerJoin(
        _db.items,
        _db.items.id.equalsExp(_db.itemPurchaseSources.itemId),
      ),
    ]);

    final results = await query.get();

    final stockMap = <int, Map<String, dynamic>>{};
    for (final row in results) {
      final item = row.readTable(_db.items);
      final src = row.readTable(_db.itemPurchaseSources);

      if (!stockMap.containsKey(item.id)) {
        stockMap[item.id] = {
          'item': item,
          'totalQuantity': 0.0,
          'avgPurchasePrice': 0.0,
        };
      }
      if (!src.isQuantityNa) {
        stockMap[item.id]!['totalQuantity'] += src.quantity ?? 0.0;
      }
    }

    return stockMap.values.toList();
  }
}

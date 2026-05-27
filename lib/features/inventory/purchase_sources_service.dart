import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final purchaseSourcesServiceProvider = Provider<PurchaseSourcesService>((ref) {
  return PurchaseSourcesService(ref.watch(databaseProvider));
});

class PurchaseSourcesService {
  final AppDatabase _db;

  PurchaseSourcesService(this._db);

  Future<List<ItemPurchaseSource>> getSourcesForItem(int itemId) {
    return (_db.select(
      _db.itemPurchaseSources,
    )..where((t) => t.itemId.equals(itemId))).get();
  }

  Future<int> addSource({
    required int itemId,
    required int wholesalerId,
    required double purchasePrice,
    double? gstRate,
    double? bardana,
    double? quantity,
    bool isQuantityNa = false,
  }) {
    return _db
        .into(_db.itemPurchaseSources)
        .insert(
          ItemPurchaseSourcesCompanion(
            itemId: Value(itemId),
            wholesalerId: Value(wholesalerId),
            purchasePrice: Value(purchasePrice),
            gstRate: Value(gstRate ?? 0.0),
            bardana: Value(bardana ?? 0.0),
            quantity: Value(quantity),
            isQuantityNa: Value(isQuantityNa),
          ),
        );
  }

  Future<void> updateSource(ItemPurchaseSource src) async {
    await (_db.update(
      _db.itemPurchaseSources,
    )..where((t) => t.id.equals(src.id))).write(
      ItemPurchaseSourcesCompanion(
        purchasePrice: Value(src.purchasePrice),
        gstRate: Value(src.gstRate),
        bardana: Value(src.bardana),
        quantity: Value(src.quantity),
        isQuantityNa: Value(src.isQuantityNa),
      ),
    );
  }

  Future<void> deleteSource(int id) async {
    await (_db.delete(
      _db.itemPurchaseSources,
    )..where((t) => t.id.equals(id))).go();
  }
}

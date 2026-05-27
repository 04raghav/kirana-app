import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../features/inventory/items_service.dart';
import '../features/retailers/retailers_service.dart';
import '../features/wholesalers/wholesalers_service.dart';
import '../features/inventory/purchase_sources_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final itemsListProvider = FutureProvider<List<Item>>((ref) {
  final service = ref.watch(itemsServiceProvider);
  return service.getItems();
});

final retailersListProvider = FutureProvider<List<Retailer>>((ref) {
  final service = ref.watch(retailersServiceProvider);
  return service.getRetailers();
});

final wholesalersListProvider = FutureProvider<List<Wholesaler>>((ref) {
  final service = ref.watch(wholesalersServiceProvider);
  return service.getWholesalers();
});

final purchaseSourcesForItemProvider =
    FutureProvider.family<List<ItemPurchaseSource>, int>((ref, itemId) {
      final service = ref.watch(purchaseSourcesServiceProvider);
      return service.getSourcesForItem(itemId);
    });

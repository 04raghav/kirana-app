import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final itemsServiceProvider = Provider<ItemsService>((ref) {
  return ItemsService(ref.watch(databaseProvider));
});

class ItemsService {
  final AppDatabase _db;

  ItemsService(this._db);

  Future<List<Item>> getItems() => _db.select(_db.items).get();

  Future<int> addItem(
    String name,
    String? type,
    double defaultBardana,
    double defaultGst,
  ) {
    return _db
        .into(_db.items)
        .insert(
          ItemsCompanion.insert(
            name: name,
            type: drift.Value(type),
            defaultBardana: drift.Value(defaultBardana),
            defaultGst: drift.Value(defaultGst),
          ),
        );
  }

  Future<void> updateItem(
    int id,
    String name,
    String? type,
    double defaultBardana,
    double defaultGst,
  ) {
    return (_db.update(_db.items)..where((t) => t.id.equals(id))).write(
      ItemsCompanion(
        name: drift.Value(name),
        type: drift.Value(type),
        defaultBardana: drift.Value(defaultBardana),
        defaultGst: drift.Value(defaultGst),
      ),
    );
  }

  Future<void> deleteItem(int id) {
    return (_db.delete(_db.items)..where((t) => t.id.equals(id))).go();
  }
}

import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final wholesalersServiceProvider = Provider<WholesalersService>((ref) {
  return WholesalersService(ref.watch(databaseProvider));
});

class WholesalersService {
  final AppDatabase _db;

  WholesalersService(this._db);

  Future<List<Wholesaler>> getWholesalers() =>
      _db.select(_db.wholesalers).get();

  Future<int> addWholesaler(String name, String? phone, String? address) {
    return _db
        .into(_db.wholesalers)
        .insert(
          WholesalersCompanion.insert(
            name: name,
            phone: drift.Value(phone),
            address: drift.Value(address),
          ),
        );
  }

  Future<void> updateWholesaler(
    int id,
    String name,
    String? phone,
    String? address,
  ) {
    return (_db.update(_db.wholesalers)..where((t) => t.id.equals(id))).write(
      WholesalersCompanion(
        name: drift.Value(name),
        phone: drift.Value(phone),
        address: drift.Value(address),
      ),
    );
  }

  Future<void> deleteWholesaler(int id) {
    return (_db.delete(_db.wholesalers)..where((t) => t.id.equals(id))).go();
  }
}

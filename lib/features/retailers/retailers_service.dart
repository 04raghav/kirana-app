import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../core/providers.dart';

final retailersServiceProvider = Provider<RetailersService>((ref) {
  return RetailersService(ref.watch(databaseProvider));
});

class RetailersService {
  final AppDatabase _db;

  RetailersService(this._db);

  Future<List<Retailer>> getRetailers() => _db.select(_db.retailers).get();

  Future<int> addRetailer(String name, String? phone, String? address) {
    return _db
        .into(_db.retailers)
        .insert(
          RetailersCompanion.insert(
            name: name,
            phone: drift.Value(phone),
            address: drift.Value(address),
          ),
        );
  }

  Future<void> updateRetailer(
    int id,
    String name,
    String? phone,
    String? address,
  ) {
    return (_db.update(_db.retailers)..where((t) => t.id.equals(id))).write(
      RetailersCompanion(
        name: drift.Value(name),
        phone: drift.Value(phone),
        address: drift.Value(address),
      ),
    );
  }

  Future<void> deleteRetailer(int id) {
    return (_db.delete(_db.retailers)..where((t) => t.id.equals(id))).go();
  }
}

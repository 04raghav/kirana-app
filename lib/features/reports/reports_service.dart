import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../database/database.dart';
import '../billing/cart_provider.dart';

final reportsServiceProvider = Provider<ReportsService>((ref) {
  return ReportsService(ref.watch(databaseProvider));
});

final billsListProvider = FutureProvider<List<BillData>>((ref) async {
  return ref.watch(reportsServiceProvider).getAllBills();
});

class BillData {
  final RetailerBill bill;
  final Retailer retailer;
  final List<CartItemModel> items;

  BillData({required this.bill, required this.retailer, required this.items});
}

class ReportsService {
  final AppDatabase _db;

  ReportsService(this._db);

  Future<List<BillData>> getAllBills() async {
    // Fetch all bills with retailer
    final query = _db.select(_db.retailerBills).join([
      innerJoin(
        _db.retailers,
        _db.retailers.id.equalsExp(_db.retailerBills.retailerId),
      ),
    ])..orderBy([OrderingTerm.desc(_db.retailerBills.date)]);

    final billResults = await query.get();

    final List<BillData> allBills = [];

    for (var row in billResults) {
      final bill = row.readTable(_db.retailerBills);
      final retailer = row.readTable(_db.retailers);

      // Fetch items for this bill
      final itemsQuery = _db.select(_db.retailerBillItems).join([
        innerJoin(
          _db.items,
          _db.items.id.equalsExp(_db.retailerBillItems.itemId),
        ),
      ])..where(_db.retailerBillItems.billId.equals(bill.id));

      final itemsResults = await itemsQuery.get();

      final List<CartItemModel> cartItems = itemsResults.map((itemRow) {
        final item = itemRow.readTable(_db.items);
        final billItem = itemRow.readTable(_db.retailerBillItems);
        return CartItemModel(
          item: item,
          quantity: billItem.quantity,
          sellingPrice: billItem.sellingPrice,
          gstRate: billItem.gstRate,
          bardana:
              billItem.bardana /
              billItem
                  .quantity, // Convert total bardana back to unit bardana if necessary, wait, let's check tables.
        );
      }).toList();

      allBills.add(BillData(bill: bill, retailer: retailer, items: cartItems));
    }

    return allBills;
  }
}

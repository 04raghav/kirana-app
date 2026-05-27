import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../database/database.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService(ref.watch(databaseProvider));
});

final analyticsDataProvider = FutureProvider<AnalyticsData>((ref) async {
  return ref.watch(analyticsServiceProvider).getAnalyticsData();
});

class AnalyticsData {
  final Map<String, double> retailerSales;
  final Map<String, double> wholesalerPurchases;

  AnalyticsData({
    required this.retailerSales,
    required this.wholesalerPurchases,
  });
}

class AnalyticsService {
  final AppDatabase _db;

  AnalyticsService(this._db);

  Future<AnalyticsData> getAnalyticsData() async {
    // 1. Retailer Sales
    // We sum up the totalAmount from RetailerBills grouped by Retailer
    final salesQuery = _db.select(_db.retailerBills).join([
      innerJoin(
        _db.retailers,
        _db.retailers.id.equalsExp(_db.retailerBills.retailerId),
      ),
    ]);

    final salesResults = await salesQuery.get();
    final Map<String, double> retailerSales = {};

    for (var row in salesResults) {
      final retailer = row.readTable(_db.retailers);
      final bill = row.readTable(_db.retailerBills);

      retailerSales[retailer.name] =
          (retailerSales[retailer.name] ?? 0.0) + bill.totalAmount;
    }

    // 2. Wholesaler Purchases
    // We use the WholesalerInventory and calculate initial quantity * purchasePrice + bardana.
    // However, WholesalerInventory quantityToSell decreases. The true total quantity received
    // is quantityToSell + sum(quantityAllocated in BillItemSources).
    // An alternative is using inventoryTransactions 'IN'. The quantity is there, but price isn't.
    // Wait, the easiest way for total purchase cost:
    // Go through WholesalerInventory, find total price as (quantityToSell + quantityAllocated) * purchasePrice + bardana.

    // Simpler method: since WholesalerInventory is created ONCE per purchase and
    // its price/bardana are fixed, we just need the ORIGINAL quantity.
    // Let's compute it:

    final whQuery = _db.select(_db.wholesalers);
    final wholesalers = await whQuery.get();
    final Map<int, String> whNames = {for (var w in wholesalers) w.id: w.name};

    final Map<String, double> wholesalerPurchases = {};

    final inventoryResults = await _db.select(_db.wholesalerInventory).get();

    for (var inv in inventoryResults) {
      // Find total allocated for this inventory
      final allocatedQuery = _db.select(_db.billItemSources)
        ..where((t) => t.inventoryId.equals(inv.id));
      final allocations = await allocatedQuery.get();
      final double totalAllocated = allocations.fold(
        0.0,
        (sum, a) => sum + a.quantityAllocated,
      );

      final double initialQuantity = inv.quantityToSell + totalAllocated;
      final double totalCost =
          (initialQuantity * inv.purchasePrice) + inv.bardana;

      final whName = whNames[inv.wholesalerId] ?? 'Unknown Wholesaler';
      wholesalerPurchases[whName] =
          (wholesalerPurchases[whName] ?? 0.0) + totalCost;
    }

    return AnalyticsData(
      retailerSales: retailerSales,
      wholesalerPurchases: wholesalerPurchases,
    );
  }
}

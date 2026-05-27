import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Items,
    Wholesalers,
    Retailers,
    WholesalerInventory,
    RetailerBills,
    RetailerBillItems,
    BillItemSources,
    ItemPurchaseSources,
    Ledgers,
    Payments,
    InventoryTransactions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1 && to >= 2) {
          // Create any new tables added in v2
          await m.createAll();

          // Migrate existing wholesaler inventory rows into ItemPurchaseSources
          final rows = await customSelect(
            'SELECT id, item_id, wholesaler_id, purchase_price, bardana, quantity_to_sell, received_at FROM wholesaler_inventory',
          ).get();

          for (final r in rows) {
            final origId = r.read<int>('id');
            final itemId = r.read<int>('item_id');
            final wholesalerId = r.read<int>('wholesaler_id');
            final purchasePrice =
                (r.data['purchase_price'] as num?)?.toDouble() ?? 0.0;
            final bardana = (r.data['bardana'] as num?)?.toDouble() ?? 0.0;
            final qty = r.data['quantity_to_sell'] as num?;
            final quantityValue = qty == null ? 'NULL' : qty.toString();
            final isNa = qty == null ? 1 : 0;

            // Insert into new table, keeping original inventory id for mapping
            await customStatement(
              'INSERT INTO item_purchase_sources (item_id, wholesaler_id, purchase_price, gst_rate, bardana, quantity, is_quantity_na, original_inventory_id, created_at, updated_at) VALUES ('
              '${itemId}, ${wholesalerId}, ${purchasePrice}, 0.0, ${bardana}, ${quantityValue}, ${isNa}, ${origId}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)',
            );
          }

          // Add purchase_source_id column to bill_item_sources for migration (if not present)
          try {
            await customStatement(
              'ALTER TABLE bill_item_sources ADD COLUMN purchase_source_id INTEGER',
            );
          } catch (_) {
            // ignore if column already exists
          }

          // Populate purchase_source_id using original_inventory_id link
          await customStatement(
            'UPDATE bill_item_sources SET purchase_source_id = (SELECT id FROM item_purchase_sources WHERE original_inventory_id = bill_item_sources.inventory_id) WHERE inventory_id IS NOT NULL',
          );
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> clearAllData() async {
    await transaction(() async {
      // Must delete in reverse dependency order to avoid foreign key constraints
      await delete(billItemSources).go();
      await delete(retailerBillItems).go();
      await delete(payments).go();
      await delete(ledgers).go();
      await delete(itemPurchaseSources).go();
      await delete(inventoryTransactions).go();
      await delete(wholesalerInventory).go();
      await delete(retailerBills).go();
      await delete(retailers).go();
      await delete(wholesalers).go();
      await delete(items).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'kirana_erp.sqlite'));

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

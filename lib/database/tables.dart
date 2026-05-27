import 'package:drift/drift.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text().nullable()();
  RealColumn get defaultBardana => real().withDefault(const Constant(0.0))();
  RealColumn get defaultGst => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Wholesalers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Retailers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class WholesalerInventory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  IntColumn get wholesalerId => integer().references(Wholesalers, #id)();
  RealColumn get quantityToSell => real()(); // Available qty
  RealColumn get purchasePrice => real()();
  RealColumn get bardana => real().withDefault(const Constant(0.0))();
  DateTimeColumn get receivedAt => dateTime().withDefault(currentDateAndTime)();
}

// New normalized purchase source: maps an Item to a Wholesaler with purchase terms.
class ItemPurchaseSources extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  IntColumn get wholesalerId => integer().references(Wholesalers, #id)();
  RealColumn get purchasePrice => real()();
  RealColumn get gstRate => real().withDefault(const Constant(0.0))();
  RealColumn get bardana => real().withDefault(const Constant(0.0))();
  // quantity can be null when N/A (infinite/not applicable). Use isQuantityNa to mark that.
  RealColumn get quantity => real().nullable()();
  BoolColumn get isQuantityNa => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Keep legacy reference to assist migration from WholesalerInventory
  IntColumn get originalInventoryId => integer().nullable()();
}

class Ledgers extends Table {
  IntColumn get id => integer().autoIncrement()();
  // 'purchase' or 'sale'
  TextColumn get ledgerType => text()();
  // party type: 'wholesaler' or 'retailer'
  TextColumn get partyType => text()();
  IntColumn get partyId => integer()();
  RealColumn get totalAmount => real()();
  RealColumn get amountPaid => real().withDefault(const Constant(0.0))();
  RealColumn get remainingAmount => real().withDefault(const Constant(0.0))();
  RealColumn get interest => real().withDefault(const Constant(0.0))();
  TextColumn get paymentMode => text().nullable()(); // Cash/Cheque/NEFT
  BoolColumn get isFullyPaid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ledgerId => integer().references(Ledgers, #id)();
  RealColumn get amount => real()();
  TextColumn get paymentMode => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();
  BoolColumn get isFullPayment =>
      boolean().withDefault(const Constant(false))();
}

class RetailerBills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get retailerId => integer().references(Retailers, #id)();
  RealColumn get totalAmount => real()();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  RealColumn get bardanaAmount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get pdfPath => text().nullable()();
}

class RetailerBillItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billId => integer().references(RetailerBills, #id)();
  IntColumn get itemId => integer().references(Items, #id)();
  RealColumn get quantity => real()();
  RealColumn get sellingPrice => real()(); // Per unit
  RealColumn get gstRate => real()();
  RealColumn get bardana => real()(); // Applied bardana
}

// Maps one retailer bill item to >0 wholesaler inventories, maintaining profit tracking.
class BillItemSources extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billItemId => integer().references(RetailerBillItems, #id)();
  // New column: purchase source (item-wholesaler mapping). Kept nullable for migration.
  IntColumn get inventoryId =>
      integer().nullable().references(WholesalerInventory, #id)();
  IntColumn get purchaseSourceId =>
      integer().nullable().references(ItemPurchaseSources, #id)();
  RealColumn get quantityAllocated => real()();
  RealColumn get purchasePriceAtTime => real()(); // Snapshot of purchase price
}

class InventoryTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  IntColumn get wholesalerId =>
      integer().nullable().references(Wholesalers, #id)();
  IntColumn get retailerId => integer().nullable().references(Retailers, #id)();
  TextColumn get type => text()(); // IN, OUT
  RealColumn get quantity => real()();
  TextColumn get referenceId => text().nullable()(); // Bill # or inward slip
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
}

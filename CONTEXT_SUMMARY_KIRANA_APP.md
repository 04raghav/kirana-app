Kirana App — Comprehensive Context Summary

Generated: 2026-05-27

Purpose

- Consolidate the full project and conversation context into a single reference file for developers and reviewers.

1. Project Overview

- Name: Kirana App
- Purpose: Offline-first Flutter ERP for small retailers (inventory, wholesaler relationships, billing, PDF invoice generation, sales analytics).
- Key features: Retail billing, PDF invoice generation, offline persistence with SQLite (Drift), charts (fl_chart), PDF printing, ledgers and payments.

2. Technical Stack

- Flutter (Dart)
- State management: flutter_riverpod
- Local DB: drift (SQLite) with generated DAOs (build_runner)
- PDF: pdf + printing packages
- Charts: fl_chart
- Platform targets: mobile/desktop/web (project contains android/ios/macos/linux/windows/web folders)

3. High-level Architecture

- Database layer: `lib/database`
  - `tables.dart` — Drift table definitions
  - `database.dart` — AppDatabase class and migration strategy
  - Generated code: `database.g.dart` (via build_runner)
- Features split under `lib/features/` (billing, inventory, wholesalers, retailers, analytics, ledger, etc.)
- Services: feature-level services (e.g., `billing_service.dart`, `inventory_service.dart`, `ledger_service.dart`)
- Providers: `lib/core/providers.dart` exports app-wide Riverpod providers.
- UI: `lib/features/*/*_screen.dart` and shared widgets in `lib/widgets` and theme in `lib/theme`.

4. Recent Work Summary (implemented during this session)

- Goal: Replace "owned stock" model with a purchase-source model and add ledger/accounting for purchases and sales.
- Primary changes:
  - Schema additions: `ItemPurchaseSources`, `Ledgers`, `Payments`.
  - Migration: schema bumped to version 2; an `onUpgrade` was implemented to convert existing `wholesaler_inventory` rows into `item_purchase_sources` and populate `bill_item_sources.purchase_source_id` where possible.
  - Billing flow: allow selecting a purchase source per bill item; store `purchaseSourceId` in `bill_item_sources`; decrement purchase-source quantities when applicable; auto-create ledger entries for purchases (per wholesaler) and a sale ledger for the retailer when a bill is generated.
  - Inventory flow: change "Receive Stock" to create `ItemPurchaseSources` (purchase source entries) rather than an owned `WholesalerInventory` row.
  - Providers & UI: added `purchaseSourcesService`, provider to fetch sources per item, updated cart model to carry `purchaseSourceId`, modified add-item dialog in billing to let users pick a wholesaler source and displayed its metadata (purchase price, GST, bardana).
  - Ledgers UI: added simple Purchases and Sales screens to navigate dates, open ledger lists, see breakdowns, and apply payments.
  - Tests/docs: not yet implemented (TODO).

5. Database Schema (summary)

- Existing tables (kept): `items`, `wholesalers`, `retailers`, `retailer_bills`, `retailer_bill_items`, `bill_item_sources`, `inventory_transactions`.
- Added tables:
  - `item_purchase_sources` (ItemPurchaseSources)
    - columns: id, item_id, wholesaler_id, purchase_price, gst_rate, bardana, quantity (nullable), is_quantity_na (bool), createdAt, updatedAt, original_inventory_id
    - semantics: maps each item to a wholesaler purchase source; `quantity` can be null or `is_quantity_na` true to represent N/A or infinite supply.
  - `ledgers` (Ledgers)
    - columns: id, ledgerType ('purchase'|'sale'), partyType ('wholesaler'|'retailer'), partyId, totalAmount, amountPaid, remainingAmount, interest, paymentMode, isFullyPaid, date, createdAt
  - `payments` (Payments)
    - columns: id, ledgerId, amount, paymentMode, date, note, isFullPayment
- `bill_item_sources` updated to include nullable `purchase_source_id` and keep `inventory_id` for migration compatibility.

6. Migration Strategy

- `AppDatabase.schemaVersion` bumped from 1 to 2.
- `onUpgrade` steps (v1 → v2):
  - Create new tables (Drift `m.createAll()`).
  - For each row in `wholesaler_inventory` insert into `item_purchase_sources` while preserving the original inventory id in `original_inventory_id`.
  - ALTER `bill_item_sources` ADD COLUMN `purchase_source_id` if needed.
  - Populate `bill_item_sources.purchase_source_id` by matching `original_inventory_id` → `inventory_id` where possible.
- A `getMigrationReport()` helper was added to `LedgerService` to expose counts (legacy rows, converted sources, bill_item_sources with purchase_source_id, etc.) for verification.

7. Files Changed / Added (selection)

- Updated: `lib/database/tables.dart` — new tables and column updates
- Updated: `lib/database/database.dart` — schemaVersion=2, onUpgrade migration, clearAllData updates
- Updated: `lib/features/billing/billing_service.dart` — uses `purchaseSourceId`, updates purchase-source quantities, auto ledger creation
- Updated: `lib/features/billing/cart_provider.dart` — cart items now carry `purchaseSourceId`
- Updated: `lib/features/billing/billing_screen.dart` — add-item dialog fetches purchase sources and shows metadata
- Updated: `lib/features/inventory/inventory_service.dart` — `addInwardInventory()` creates `ItemPurchaseSources`; `getAvailableStock()` aggregates purchase sources
- Added: `lib/features/inventory/purchase_sources_service.dart` — CRUD for purchase sources
- Added: `lib/features/ledger/ledger_service.dart` — ledger helpers and migration report
- Added UI: `lib/features/ledger/purchases_screen.dart`, `lib/features/ledger/sales_screen.dart`
- Updated providers: `lib/core/providers.dart` — added `purchaseSourcesForItemProvider`

8. Behavior Changes / Business Logic

- Inventory ownership removed: the app now models purchase sources; the app does NOT keep stock as owned centrally. Instead, each item may have multiple purchase sources (wholesalers) with their purchase prices, GST, bardana, and optional quantity.
- Billing flow: when adding an item to a bill, user should select the purchase source (wholesaler). The selling price remains editable. The bill generation stores purchase-source references internally but does not include wholesaler details in the retail PDF.
- Ledger automation: on bill creation the system creates a sale ledger for the retailer and purchase ledgers for each wholesaler involved with amounts aggregated. Payments can be applied which create `payments` entries and update ledger balances.
- Migration: existing `wholesaler_inventory` rows are converted into `item_purchase_sources` (with `original_inventory_id` retained). Legacy columns (`inventory_id` in `bill_item_sources`) are retained for safety during migration.

9. How to Run (developer)

- Regenerate code after schema changes:
  ```bash
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- Launch the app (choose a device):
  ```bash
  flutter run
  ```

  - On first run after schema bump the `onUpgrade` code will execute and perform the conversion.

10. Manual Verification Steps

- Inventory → Receive Stock: create at least one purchase source for an item.
- Billing → Add item: select purchase source when adding item; confirm that source metadata is displayed and selling price remains editable.
- Generate bill: ensure PDF is generated (no wholesaler details), and in the DB:
  - `bill_item_sources.purchase_source_id` should be set for items using purchase sources.
  - A `ledger` row of type `sale` should be created for the retailer.
  - One or more `ledger` rows of type `purchase` should be created for each wholesaler involved.
- Purchases screen → Open migration report (AppBar Info): confirm counts make sense.
- Ledger detail → Apply Payment: apply a payment and confirm `payments` entry appears and ledger totals update.

11. Remaining Tasks / Recommendations

- Finish data-migration verification and optionally remove legacy `wholesaler_inventory` once confirmed safe.
- Add tests (unit/integration) for:
  - Migration (verify that item_purchase_sources rows created correctly)
  - Billing flow that creates ledgers
  - Payment application updates ledgers correctly
- Improve UI polish:
  - Show wholesaler names in all lists rather than IDs
  - Allow editing purchase sources from item detail screen
  - Show chosen purchase source in cart and editable per-cart-item
- Extend reporting/analytics to include purchase-side data (cost of goods sold, margin per sale, wholesaler-wise purchases)
- Add migrations note to `README.md` and a quick rollback plan if problems occur.

12. Quick DB Introspection Queries (useful during verification)

- Count legacy rows: `SELECT COUNT(*) FROM wholesaler_inventory;`
- Count converted sources: `SELECT COUNT(*) FROM item_purchase_sources WHERE original_inventory_id IS NOT NULL;`
- Bill item sources using a purchase source: `SELECT COUNT(*) FROM bill_item_sources WHERE purchase_source_id IS NOT NULL;`
- Example join for ledger breakup (purchase):
  ```sql
  SELECT bis.id, ips.id as purchase_source_id, w.name as wholesaler_name, i.name as item_name, rbi.quantity, bis.purchase_price_at_time, rb.date
  FROM bill_item_sources bis
  JOIN item_purchase_sources ips ON ips.id = bis.purchase_source_id
  JOIN wholesalers w ON w.id = ips.wholesaler_id
  JOIN retailer_bill_items rbi ON rbi.id = bis.bill_item_id
  JOIN items i ON i.id = rbi.item_id
  JOIN retailer_bills rb ON rb.id = rbi.bill_id
  WHERE ips.wholesaler_id = :wholesalerId
  ORDER BY rb.date DESC;
  ```

13. Where to find key files

- Database and schema: `lib/database/tables.dart`, `lib/database/database.dart`
- Billing service: `lib/features/billing/billing_service.dart`
- Billing UI: `lib/features/billing/billing_screen.dart`
- Cart provider: `lib/features/billing/cart_provider.dart`
- Inventory service and UI: `lib/features/inventory/inventory_service.dart`, `lib/features/inventory/inventory_screen.dart`
- Purchase sources service: `lib/features/inventory/purchase_sources_service.dart`
- Ledger service and UIs: `lib/features/ledger/ledger_service.dart`, `lib/features/ledger/purchases_screen.dart`, `lib/features/ledger/sales_screen.dart`
- Providers: `lib/core/providers.dart`

14. Last actions performed by the assistant (automation)

- Created and edited the files listed above to implement the new purchase-source model and ledger system.
- Ran `flutter pub run build_runner build` to regenerate Drift code after schema changes.
- Started the app (`flutter run`) to allow the user to choose a device and trigger migration.

15. Contact / Next steps

- If you want me to continue I can:
  - Run the app interactively and walk through flows, reporting observed runtime behavior
  - Implement automated tests for migration and billing/ledger automation
  - Further polish UI and add admin screens for managing purchase sources
  - Prepare a migration rollback plan and README section

-- End of context summary

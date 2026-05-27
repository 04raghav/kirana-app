# Kirana App - Comprehensive Project Context

Generated: 2026-05-27

This document is the long-form reference for the project. It captures the business model, architecture, modules, data model, workflow behavior, current implementation status, and development conventions.

## 1. Project Overview

Kirana App is an offline-first Flutter ERP for small retailers. It is designed to work without a server by storing all business data locally in SQLite through Drift.

Primary goals:

- Manage items, wholesalers, and retailers.
- Generate retail bills and PDF invoices.
- Track purchase and sale ledgers.
- Preserve local-only data and work offline.
- Support a purchase-source model rather than owned inventory.

## 2. Business Model

Current business model:

Wholesaler -> Purchase Source -> Retail Sale

Important business rule:

- The app no longer uses owned stock as the source of truth.
- Inventory is represented as purchase sources tied to an item and a wholesaler.
- A purchase source carries terms such as purchase price, GST, bardana, and quantity.

Quantity semantics:

- Numeric quantity means the source has measurable available stock.
- N/A means the quantity is not applicable or effectively unlimited.

This model is reflected in both the database schema and the billing flow.

## 3. Repository Structure

Top-level structure:

- `lib/` - Flutter application code.
- `android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/` - platform runners.
- `test/` - Flutter tests.
- `README.md` - short project entry point.

Core app directories:

- `lib/main.dart` - app bootstrap and MaterialApp entry.
- `lib/core/` - Riverpod providers and shared application wiring.
- `lib/database/` - Drift schema, database class, and migration logic.
- `lib/features/` - feature modules for dashboard, billing, inventory, retailers, wholesalers, analytics, ledger, and reports.
- `lib/services/` - cross-feature services such as PDF generation.
- `lib/widgets/` - shared UI helpers and reusable widgets.
- `lib/theme/` - app colors and text styles.

## 4. Application Entry And Navigation

The app boots from `lib/main.dart` into a `MaterialApp` with `DashboardScreen` as the home route.

Dashboard navigation currently exposes:

- Billing (POS)
- Inventory
- Retailers
- Wholesalers
- Analytics
- Reports & Backups

Dashboard also contains a destructive cleanup action that clears all local data.

## 5. Feature Map

### 5.1 Dashboard

Location: `lib/features/dashboard/dashboard_screen.dart`

Role:

- Acts as the main hub for the application.
- Provides tile-based navigation into the feature modules.

### 5.2 Billing

Locations:

- `lib/features/billing/billing_screen.dart`
- `lib/features/billing/billing_service.dart`
- `lib/features/billing/cart_provider.dart`

Role:

- Select a retailer.
- Add items to the cart.
- Select a purchase source for an item when available.
- Keep retail selling price editable.
- Generate a bill, create internal tracking rows, and produce a PDF.

### 5.3 Inventory

Locations:

- `lib/features/inventory/inventory_screen.dart`
- `lib/features/inventory/items_service.dart`
- `lib/features/inventory/inventory_service.dart`
- `lib/features/inventory/purchase_sources_service.dart`

Role:

- Manage item catalog entries.
- Manage purchase sources per item.
- Remove the old Receive Stock UI from the user flow.

### 5.4 Retailers

Location: `lib/features/retailers/retailers_screen.dart` and `lib/features/retailers/retailers_service.dart`

Role:

- Maintain retailer master data.
- Support billing recipients.

### 5.5 Wholesalers

Location: `lib/features/wholesalers/wholesalers_screen.dart` and `lib/features/wholesalers/wholesalers_service.dart`

Role:

- Maintain supplier master data.
- Provide wholesaler selection in purchase-source flows.

### 5.6 Analytics

Location: `lib/features/analytics/analytics_screen.dart` and `lib/features/analytics/analytics_service.dart`

Role:

- Summarize business data and trends.
- Uses local database queries and charting support.

### 5.7 Reports And Backups

Locations:

- `lib/features/reports/reports_screen.dart`
- `lib/features/reports/reports_service.dart`
- `lib/features/reports/backup_service.dart`

Role:

- List generated bills.
- Regenerate or print bill PDFs.
- Provide report and backup related utilities.

### 5.8 Ledger

Location: `lib/features/ledger/ledger_service.dart` plus purchase and sales screens under `lib/features/ledger/`

Role:

- Manage purchase and sale ledger records.
- Apply payments.
- Expose migration verification data.

Note:

- Ledger screens exist in the codebase even if they are not currently a dashboard tile.

## 6. Data Model

The schema is implemented in `lib/database/tables.dart` and compiled through Drift into `lib/database/database.g.dart`.

### 6.1 Core Tables

- `items`
- `wholesalers`
- `retailers`
- `retailer_bills`
- `retailer_bill_items`
- `bill_item_sources`
- `inventory_transactions`

### 6.2 Purchase-Source Model

New table:

- `item_purchase_sources`

Purpose:

- Connects an item to a wholesaler with purchase terms.

Fields:

- `item_id`
- `wholesaler_id`
- `purchase_price`
- `gst_rate`
- `bardana`
- `quantity`
- `is_quantity_na`
- `createdAt`
- `updatedAt`
- `original_inventory_id`

### 6.3 Ledger Model

New table:

- `ledgers`

Purpose:

- Track sale balances for retailers.
- Track purchase balances for wholesalers.

### 6.4 Payments Model

New table:

- `payments`

Purpose:

- Store payment history against a ledger.

### 6.5 Bill Item Source Mapping

`bill_item_sources` now includes:

- `purchase_source_id` - nullable reference to `item_purchase_sources`.
- `inventory_id` - retained for legacy migration compatibility.

## 7. Migration Strategy

Schema version:

- Current schema version is 2.

Upgrade logic:

- Create the newer tables.
- Convert legacy `wholesaler_inventory` rows into `item_purchase_sources`.
- Preserve the legacy inventory row id in `original_inventory_id`.
- Add `purchase_source_id` to `bill_item_sources` when needed.
- Populate `purchase_source_id` by matching migrated inventory rows where possible.

Why the old table still exists:

- It provides compatibility during migration.
- It also acts as a fallback path in billing where source-specific stock is unavailable.

## 8. Business Workflows

### 8.1 Inventory Workflow

Current flow:

1. Open Inventory.
2. Select an item.
3. View that item's purchase sources.
4. Add, edit, or delete purchase sources.

The old Receive Stock flow is obsolete and removed from the user-facing UI.

### 8.2 Billing Workflow

Current flow:

1. Select a retailer.
2. Tap an item.
3. Choose a purchase source if the item has one.
4. Autofill purchase price, GST, and bardana from the selected source.
5. Edit the selling price freely.
6. Generate the bill.

Billing behavior:

- Internal records keep `purchaseSourceId` and `bill_item_sources.purchase_source_id`.
- Retail PDF output does not show wholesaler details.

### 8.3 Ledger And Payments Workflow

On bill generation:

- A sale ledger is created for the retailer.
- Purchase ledgers are created for wholesalers involved in the bill.
- Payment history can later reduce outstanding balances.

## 9. Shared UI And App Conventions

The app uses a small set of shared UI helpers:

- `CommonAppBar`
- `showCommonDialog`
- `showCommonSnackbar`

These live in `lib/widgets/common_widgets.dart` and are preferred over ad hoc variants where possible.

Riverpod conventions:

- Global providers are centralized in `lib/core/providers.dart`.
- Feature services are wrapped in providers and consumed from UI widgets.

Database conventions:

- Drift is the source of truth for table definitions.
- Generated code is not hand-edited.
- Migration logic lives in the database class rather than in UI code.

## 10. Current Implementation Status

Implemented:

- Offline SQLite persistence with Drift.
- Purchase-source model for inventory.
- Billing flow with purchase-source selection.
- PDF invoice generation.
- Ledger creation and payment tracking.
- Reports and backup-related UI.
- Inventory UI cleanup away from Receive Stock.

Partially implemented:

- Some legacy fallback code paths remain in the backend for migration compatibility.
- Ledger screens exist but are not yet surfaced as a primary dashboard destination.

Still recommended:

- Automated tests for migration and billing flows.
- Optional cleanup of legacy compatibility paths after data migration confidence is high.
- Documentation refresh in code comments and feature-specific help text where needed.

## 11. Development Commands

Typical workflow:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

Notes:

- Run build_runner after schema or Drift table changes.
- Use `flutter analyze` to catch compile and lint issues early.
- Use `flutter run` for runtime verification on a device or emulator.

## 12. Verification Checklist

Use this checklist when validating the business flow:

- Inventory opens item-based purchase-source management.
- No Receive Stock UI remains in the app.
- Purchase sources can be added, edited, and deleted per item.
- Billing lets the user choose a purchase source from an item.
- Selecting a purchase source autofills purchase terms.
- Selling price stays editable.
- Retail PDF does not expose wholesaler details.
- Ledger rows are created for sale and purchase tracking.
- Payments can be applied to ledgers.

## 13. Useful File Map

- App entry: `lib/main.dart`
- Dashboard: `lib/features/dashboard/dashboard_screen.dart`
- Billing UI: `lib/features/billing/billing_screen.dart`
- Billing service: `lib/features/billing/billing_service.dart`
- Cart state: `lib/features/billing/cart_provider.dart`
- Inventory UI: `lib/features/inventory/inventory_screen.dart`
- Inventory service: `lib/features/inventory/inventory_service.dart`
- Purchase source CRUD: `lib/features/inventory/purchase_sources_service.dart`
- Database schema: `lib/database/tables.dart`
- Database migration: `lib/database/database.dart`
- Ledger logic: `lib/features/ledger/ledger_service.dart`
- Reports: `lib/features/reports/reports_screen.dart`
- Shared widgets: `lib/widgets/common_widgets.dart`

## 14. Current Working Notes

- The latest codebase state already includes the purchase-source backend and billing automation.
- The main remaining work is typically UI polish, tests, and optional cleanup of legacy compatibility paths.
- Analyzer runs currently report info-level lint items in untouched legacy files, but no compile errors in the recent purchase-source UI work.

## 15. Reference Files

- This document: [PROJECT_CONTEXT_KIRANA_APP.md](PROJECT_CONTEXT_KIRANA_APP.md)
- Short entry point: [README.md](README.md)
- Prior summary: [CONTEXT_SUMMARY_KIRANA_APP.md](CONTEXT_SUMMARY_KIRANA_APP.md)

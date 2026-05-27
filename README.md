# Kirana App

Kirana App is an offline-first Flutter ERP for small retailers. It focuses on billing, inventory cataloging, wholesaler purchase sources, ledgers, PDF invoices, reports, and local-only data storage with Drift/SQLite.

## What The App Does

- Manages items, wholesalers, and retailers.
- Models inventory as purchase sources instead of owned stock.
- Generates retail bills and PDFs.
- Tracks purchase and sale ledgers.
- Stores all business data locally for offline use.

## Current App Flow

The app opens on the dashboard and exposes the main modules:

- Billing (POS)
- Inventory
- Retailers
- Wholesalers
- Analytics
- Reports & Backups

Inventory now manages items and their purchase sources. Billing lets the user pick a retailer, add items, select a purchase source, and keep the selling price editable. Reports lists generated bills and can regenerate PDFs.

## Tech Stack

- Flutter and Dart
- Riverpod for state management
- Drift with SQLite for local persistence
- PDF and printing packages for invoices
- fl_chart for analytics and charts

## Project Structure

- `lib/main.dart` - app entrypoint and MaterialApp bootstrap.
- `lib/core/` - Riverpod providers and shared app wiring.
- `lib/database/` - Drift tables, database class, and migration logic.
- `lib/features/` - feature modules for billing, inventory, retailers, wholesalers, analytics, ledger, and reports.
- `lib/services/` - cross-feature services such as PDF generation.
- `lib/widgets/` - shared UI components such as the common app bar and dialog helpers.
- `lib/theme/` - shared colors and text styles.

## Business Model

The current business model is:

Wholesaler -> Purchase Source -> Retail Sale

The app no longer uses owned inventory as the source of truth. Instead, each item can have multiple purchase sources with price, GST, bardana, and optional quantity. A quantity marked as N/A means the source is not quantity-limited or not applicable.

## Key Data Model

- `items` - product catalog.
- `wholesalers` - source businesses supplying stock.
- `retailers` - customers buying goods.
- `item_purchase_sources` - item-to-wholesaler purchase terms.
- `retailer_bills` and `retailer_bill_items` - retail invoices.
- `bill_item_sources` - links bill items to purchase sources for internal tracking.
- `ledgers` - purchase and sale balances.
- `payments` - payments applied to ledgers.
- `inventory_transactions` - movement log for purchases and sales.

## Main Workflows

### Inventory

- Add or manage items.
- Open an item to view its purchase sources.
- Add, edit, or delete a purchase source.
- Use numeric quantity or mark quantity as N/A.

### Billing

- Select a retailer.
- Add items to the cart.
- Choose a purchase source when available.
- Autofill purchase price, GST, and bardana from the selected source.
- Keep the selling price editable.
- Generate a bill and PDF without showing wholesaler details on the retail invoice.

### Ledger And Reports

- Create sale ledgers for retailers and purchase ledgers for wholesalers.
- Apply payments to ledger balances.
- View generated bills in Reports and regenerate PDFs.

## Current Implementation Status

- Implemented: billing, purchase-source management backend, PDF invoices, ledgers, and migration logic.
- Implemented: inventory UI cleanup so Receive Stock is removed from the user flow.
- Partially implemented: some legacy compatibility paths still exist in the database and billing service for migration safety.
- Pending: automated tests for migration, billing, and payment flows.

## Development Setup

Run these commands from the project root:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

## Useful Notes

- The app uses Drift-generated code in `lib/database/database.g.dart`.
- The database schema has migration logic for converting legacy wholesaler inventory rows into purchase sources.
- Shared dialog and snackbar helpers live in `lib/widgets/common_widgets.dart`.
- The dashboard is the main navigation hub for the app.

## Comprehensive Context

See [PROJECT_CONTEXT_KIRANA_APP.md](PROJECT_CONTEXT_KIRANA_APP.md) for the full business, architecture, workflow, and operational reference.

# Kirana App - Conversation Context

Generated: 2026-05-27

This document captures the current conversation state for the Kirana App workspace, with emphasis on the billing, purchase-source, and ledger/cash-flow follow-up task.

## 1. Conversation Purpose

The conversation has covered three distinct pieces of work:

1. Project-wide context generation.
2. Billing purchase-source UI fixes.
3. A new continuation task for purchase/sales cash-flow management and ledger UI.

This file preserves the latest conversation-specific requirements and implementation state so the next turn can continue without re-auditing unrelated project areas.

## 2. Current Project State

The app is an offline-first Flutter ERP for small retailers. The codebase already includes:

- Local SQLite persistence with Drift.
- Item, wholesaler, and retailer master data.
- Purchase-source inventory model.
- Billing flow with purchase-source selection.
- PDF invoice generation.
- Ledger tables for purchase and sale balances.
- Payments table for payment history.

The following are already in place and should generally be reused rather than recreated:

- `lib/database/tables.dart`
- `lib/database/database.dart`
- `lib/features/inventory/purchase_sources_service.dart`
- `lib/core/providers.dart`
- `lib/features/billing/billing_service.dart`
- `lib/features/billing/cart_provider.dart`
- `lib/features/billing/billing_screen.dart`
- `lib/features/ledger/ledger_service.dart`
- `lib/features/ledger/purchases_screen.dart`
- `lib/features/ledger/sales_screen.dart`

## 3. Latest Billing Fix Context

A recent runtime issue occurred when generating a bill:

- Error pattern: SQLite NOT NULL constraint failure on `bill_item_sources.inventory_id`.
- Root cause: the purchase-source billing path was inserting `bill_item_sources` rows without a legacy `inventory_id` value, but the live database still enforces that column.
- Fix direction taken: preserve the new purchase-source model while writing a legacy inventory row id where required for compatibility.

This issue is relevant because it shows the codebase still has a transitional schema boundary between old inventory and new purchase-source data.

## 4. New Continuation Task

The current task is to implement missing purchase/sales cash-flow management only.

Do not reimplement:

- purchase-source backend
- inventory model changes
- billing UI purchase-source selection
- migration logic
- PDF generation
- existing ledger tables

The existing ledger tables are present. The gap is the workflow/UI layer that exposes balances, payments, breakup tracking, and date-wise grouping.

## 5. Required Business Flow

The required flow is:

Generate Bill

-> Auto create records

-> Purchase side (wholesalers)

and

-> Sales side (retailers)

-> Date wise grouping

-> Party list

-> Bill breakup

## 6. Purchase Flow Requirements

For the purchase side, the UI should behave like this:

Purchases

-> Date list

Example:

- 20 May
- 21 May
- 22 May

Tap a date

-> Show wholesaler list for that date

Example row fields:

- Name
- Total Purchase
- Amount Paid
- Remaining Amount
- Interest
- Payment Mode
- Fully Paid checkbox

Payment mode options:

- Cash
- Cheque
- NEFT

Behavior:

- If Fully Paid is checked, remaining becomes 0 and amount paid becomes total amount.

## 7. Sales Flow Requirements

Sales should mirror the purchase flow:

Sales

-> Date list

Tap a date

-> Show retailer list for that date

Required row fields:

- Retailer Name
- Total Sale
- Amount Paid
- Remaining
- Interest
- Payment Mode
- Fully Paid

## 8. Detail Breakup Screen Requirements

When a user taps a retailer or wholesaler row, the app should open a detailed bill breakup screen.

The breakup should show:

- Bill date
- Items
- Quantity
- Purchase price
- Selling price
- GST
- Bardana
- Totals
- Internal source references

Important business rule:

- Retail-facing views must not expose the wholesaler purchase chain.
- Internal tracking can use purchase-source ids and bill item source rows.

## 9. Payments System Requirements

The ledger detail screen needs actual payment history management.

Required payment UI:

- Add Payment button
- Payment form
- Amount
- Date
- Mode
- Note
- Full payment checkbox

Payment persistence:

- Save to the existing `payments` table.
- Update `amountPaid`.
- Update `remainingAmount`.
- Update `isFullyPaid`.
- Keep payment history.
- Do not overwrite old payments.

## 10. Automation Requirements

When a bill is generated, the app should automatically create:

- 1 sale ledger for the retailer
- purchase ledgers grouped by wholesaler
- aggregated amounts per wholesaler

This part is already partially implemented in the billing service, but the conversation task requires confirming the missing UI/workflow pieces and any missing data handling.

## 11. UI Requirements

The ledger workflow should expose:

- PurchasesScreen
- SalesScreen
- DateListScreen behavior
- PartyLedgerScreen behavior
- BreakupScreen behavior
- PaymentDialog

Shared UI helpers to reuse:

- `CommonAppBar`
- `showCommonDialog`
- `showCommonSnackbar`

Do not introduce raw duplicated Material-only flows if the shared helpers already fit.

## 12. Current Implementation Snapshot

Based on the current code read during this conversation:

Implemented:

- `ledger_service.dart` already has:
  - `getLedgersByTypeAndDate`
  - `getLedgersForDate`
  - `getLedgerBreakup`
  - `getMigrationReport`
  - `applyPayment`

Also implemented in the latest state:

- `clearAllData()` now resets SQLite autoincrement counters so invoices restart from `#1` after a full wipe.
- `purchases_screen.dart` now provides the full date list -> party list -> breakup flow with payment history and payment entry UI.
- `sales_screen.dart` now routes into the same ledger flow for retailer-ledger browsing.
- `dashboard_screen.dart` now exposes explicit Purchases and Sales tiles.
- Payment history is stored additively in the existing `payments` table and shown newest-first in the ledger detail view.

Missing or incomplete:

- Only minor UX polish and follow-up verification remain; the core purchase/sales cash-flow workflow is now present.

## 13. Files Most Likely To Change In The Next Step

The next implementation step should stay scoped to these files or near-neighbors:

- `lib/features/ledger/ledger_service.dart`
- `lib/features/ledger/purchases_screen.dart`
- `lib/features/ledger/sales_screen.dart`
- `lib/features/dashboard/dashboard_screen.dart`
- possibly small shared UI helpers if needed

Most likely follow-up work is now limited to polish, tests, and any runtime-only edge cases discovered during manual verification.

Avoid touching unrelated backend areas unless a concrete compile/runtime issue forces it.

## 14. Risks And Constraints

Important constraints from the conversation:

- Do not rework purchase-source backend logic.
- Do not rework inventory migration.
- Do not rework PDF generation.
- Do not duplicate ledger tables.
- Preserve the new purchase-source billing flow.
- Keep ledger/payments history additive, not destructive.

Likely edge cases to keep in mind:

- Older database rows may still reference legacy inventory ids.
- Some ledger records may need to render with fallback labels rather than ids.
- Payment updates must not delete previous payment rows.

## 15. Validation Expectations

Once the missing ledger UI/workflow is implemented, validation should include:

- `flutter analyze`
- `flutter run`
- manual checks for:
  - bill generation
  - date grouping
  - party lists
  - payment updates
  - remaining balance updates
  - breakup navigation

Current validation state:

- `flutter analyze` is clean for the touched ledger and database files; only unrelated legacy info warnings remain in `lib/services/pdf_service.dart`.
- `flutter run -d windows` currently fails in the Windows toolchain with MSB3073 during the install step, which appears environmental rather than app-code related.

## 16. Conversation Outcome So Far

The conversation has established the current scope:

- Billing purchase-source selection has been fixed.
- The purchase/sales cash-flow UI, payment history, and bill-breakup flow are now implemented.
- The remaining work is verification and small polish rather than feature build-out.

This document should be treated as the current working context for the ledger follow-up task.

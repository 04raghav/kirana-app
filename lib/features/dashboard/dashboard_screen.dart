import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kirana_app/features/ledger/purchases_screen.dart';
import 'package:kirana_app/features/ledger/sales_screen.dart';

import '../../core/providers.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/kirana_card.dart';
import '../../theme/app_colors.dart';
import '../billing/billing_screen.dart';
import '../inventory/inventory_screen.dart';
import '../retailers/retailers_screen.dart';
import '../wholesalers/wholesalers_screen.dart';
import '../analytics/analytics_screen.dart';
import '../reports/reports_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Kirana ERP Dashboard',
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            tooltip: 'Clear All Data',
            onPressed: () {
              showCommonDialog(
                context: context,
                title: "Clear All Data",
                content: const Text(
                  "Are you sure you want to delete all app data? This action cannot be undone.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close dialog

                      // Clear the database
                      final db = ref.read(databaseProvider);
                      await db.clearAllData();

                      // Refresh all lists
                      ref.invalidate(itemsListProvider);
                      ref.invalidate(retailersListProvider);
                      ref.invalidate(wholesalersListProvider);

                      if (context.mounted) {
                        showCommonSnackbar(
                          context,
                          "All data has been wiped clean.",
                        );
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            KiranaCard(
              title: 'Billing (POS)',
              icon: Icons.receipt_long,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BillingScreen()),
                );
              },
            ),
            KiranaCard(
              title: 'Inventory',
              icon: Icons.inventory,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const InventoryScreen()),
                );
              },
            ),
            KiranaCard(
              title: 'Retailers',
              icon: Icons.store,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RetailersScreen()),
                );
              },
            ),
            KiranaCard(
              title: 'Wholesalers',
              icon: Icons.local_shipping,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const WholesalersScreen()),
                );
              },
            ),
            KiranaCard(
              title: 'Analytics',
              icon: Icons.analytics,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                );
              },
            ),
            KiranaCard(
              title: 'Reports & Backups',
              icon: Icons.backup,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ReportsScreen()),
                );
              },
            ),
            KiranaCard(
              title: "Purchases",
              icon: Icons.receipt_long,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PurchasesScreen()),
                );
              },
            ),
            KiranaCard(
              title: "Sales",
              icon: Icons.point_of_sale,
              color: AppColors.deepAmber,
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SalesScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

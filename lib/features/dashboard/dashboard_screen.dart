import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/common_widgets.dart';
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
            icon: const Icon(Icons.delete_forever, color: Colors.white),
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
                      backgroundColor: Colors.red,
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
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
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
            _DashboardCard(
              title: 'Billing (POS)',
              icon: Icons.receipt_long,
              color: Colors.blue,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BillingScreen()),
                );
              },
            ),
            _DashboardCard(
              title: 'Inventory',
              icon: Icons.inventory,
              color: Colors.orange,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const InventoryScreen()),
                );
              },
            ),
            _DashboardCard(
              title: 'Retailers',
              icon: Icons.store,
              color: Colors.green,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RetailersScreen()),
                );
              },
            ),
            _DashboardCard(
              title: 'Wholesalers',
              icon: Icons.local_shipping,
              color: Colors.purple,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const WholesalersScreen()),
                );
              },
            ),
            _DashboardCard(
              title: 'Analytics',
              icon: Icons.analytics,
              color: Colors.red,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                );
              },
            ),
            _DashboardCard(
              title: 'Reports & Backups',
              icon: Icons.backup,
              color: Colors.teal,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ReportsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

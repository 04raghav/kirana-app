import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/common_widgets.dart';
import 'analytics_service.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsDataProvider);

    return Scaffold(
      appBar: const CommonAppBar(title: 'Analytics'),
      body: analyticsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (data) {
          final topRetailers = data.retailerSales;
          final topWholesalers = data.wholesalerPurchases;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildChartSection(
                title: 'Retailer Sales',
                dataMap: topRetailers,
                isEmpty: topRetailers.values.every((v) => v == 0),
              ),
              const SizedBox(height: 32),
              _buildChartSection(
                title: 'Wholesaler Purchases',
                dataMap: topWholesalers,
                isEmpty: topWholesalers.values.every((v) => v == 0),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required Map<String, double> dataMap,
    required bool isEmpty,
  }) {
    if (isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text("No data available yet."),
            ],
          ),
        ),
      );
    }

    final total = dataMap.values.fold(0.0, (sum, val) => sum + val);

    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];

    int colorIndex = 0;
    final sections = dataMap.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      final section = PieChartSectionData(
        color: colors[colorIndex % colors.length],
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      colorIndex++;
      return section;
    }).toList();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: dataMap.entries.map((entry) {
                final idx = dataMap.keys.toList().indexOf(entry.key);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: colors[idx % colors.length],
                    ),
                    const SizedBox(width: 4),
                    Text('${entry.key} (₹${entry.value.toStringAsFixed(2)})'),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

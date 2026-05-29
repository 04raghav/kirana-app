import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kirana_app/theme/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../theme/app_text_styles.dart';
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

          final monthlySales = data.monthlySales;
          final monthlyPurchases = data.monthlyPurchases;

          final totalSales = topRetailers.values.fold(0.0, (a, b) => a + b);
          final totalPurchases = topWholesalers.values.fold(
            0.0,
            (a, b) => a + b,
          );
          final outstandingReceivables = 0.0;
          final outstandingPayables = 0.0;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _KpiCard(title: 'Total Sales', value: totalSales),
                  _KpiCard(title: 'Total Purchases', value: totalPurchases),
                  _KpiCard(
                    title: 'Outstanding Receivables',
                    value: outstandingReceivables,
                  ),
                  _KpiCard(
                    title: 'Outstanding Payables',
                    value: outstandingPayables,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Doughnut charts
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  final chartColumn = [
                    Expanded(
                      child: _ChartPanel(
                        title: 'Retailer Sales',
                        child: SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            textStyle: AppTextStyles.caption.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          palette: AppColors.chartPalette,
                          series: <CircularSeries>[
                            DoughnutSeries<_ChartData, String>(
                              dataSource: topRetailers.entries
                                  .map((e) => _ChartData(e.key, e.value))
                                  .toList(),
                              xValueMapper: (d, _) => d.x,
                              yValueMapper: (d, _) => d.y,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12, height: 12),
                    Expanded(
                      child: _ChartPanel(
                        title: 'Wholesaler Purchases',
                        child: SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            textStyle: AppTextStyles.caption.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          palette: AppColors.chartPalette,
                          series: <CircularSeries>[
                            DoughnutSeries<_ChartData, String>(
                              dataSource: topWholesalers.entries
                                  .map((e) => _ChartData(e.key, e.value))
                                  .toList(),
                              xValueMapper: (d, _) => d.x,
                              yValueMapper: (d, _) => d.y,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];

                  if (isWide) {
                    return Row(children: chartColumn);
                  }
                  return Column(
                    children: [
                      chartColumn[0],
                      const SizedBox(height: 12),
                      chartColumn[2],
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              // Bar charts for monthly
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Sales',
                        style: AppTextStyles.sectionHeading,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 240,
                        child: SfCartesianChart(
                          palette: AppColors.chartPalette,
                          primaryXAxis: CategoryAxis(),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CartesianSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                              dataSource: monthlySales.entries
                                  .map((e) => _ChartData(e.key, e.value))
                                  .toList(),
                              xValueMapper: (d, _) => d.x,
                              yValueMapper: (d, _) => d.y,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Purchases',
                        style: AppTextStyles.sectionHeading,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 240,
                        child: SfCartesianChart(
                          palette: AppColors.chartPalette,
                          primaryXAxis: CategoryAxis(),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CartesianSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                              dataSource: monthlyPurchases.entries
                                  .map((e) => _ChartData(e.key, e.value))
                                  .toList(),
                              xValueMapper: (d, _) => d.x,
                              yValueMapper: (d, _) => d.y,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChartData {
  final String x;
  final double y;
  _ChartData(this.x, this.y);
}

class _KpiCard extends StatelessWidget {
  final String title;
  final double value;

  const _KpiCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 220),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.sectionHeading),
              const SizedBox(height: 8),
              Text(
                '₹${value.toStringAsFixed(2)}',
                style: AppTextStyles.display.copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartPanel extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartPanel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: AppTextStyles.sectionHeading),
            const SizedBox(height: 8),
            SizedBox(height: 240, child: child),
          ],
        ),
      ),
    );
  }
}

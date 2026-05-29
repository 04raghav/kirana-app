import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/ledger/ledger_service.dart';
import 'ledger_detail_screen.dart';
import '../../database/database.dart';
import '../../widgets/common_widgets.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../core/providers.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Sales'),
      body: FutureBuilder<List<Ledger>>(
        future: ref.read(ledgerServiceProvider).getLedgersByTypeAndDate('sale'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty) {
            return const Center(child: Text('No sales yet'));
          }

          final Map<String, List<Ledger>> grouped = {};
          for (final l in ledgers) {
            final key = DateTime(
              l.date.year,
              l.date.month,
              l.date.day,
            ).toIso8601String();
            grouped.putIfAbsent(key, () => []).add(l);
          }

          final dates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final dateKey = dates[index];
              final dateLedgers = grouped[dateKey]!;
              final date = DateTime.parse(dateKey);
              final total = dateLedgers.fold<double>(
                0,
                (s, l) => s + l.totalAmount,
              );
              return ListTile(
                title: Text('${date.day}-${date.month}-${date.year}'),
                subtitle: Text('Total: ₹${total.toStringAsFixed(2)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SalesDateDetailScreen(date: date),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class SalesDateDetailScreen extends ConsumerWidget {
  final DateTime date;
  const SalesDateDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Sales ${date.day}-${date.month}-${date.year}',
      ),
      body: FutureBuilder<List<Ledger>>(
        future: ref.read(ledgerServiceProvider).getLedgersForDate(date, 'sale'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty) {
            return const Center(child: Text('No sales for this date'));
          }
          final retailersAsync = ref.watch(retailersListProvider);
          return retailersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
            data: (retailers) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(label: Text('Retailer')),
                    DataColumn2(label: Text('Total')),
                    DataColumn2(label: Text('Paid')),
                    DataColumn2(label: Text('Remaining')),
                    DataColumn2(label: Text('Interest')),
                    DataColumn2(label: Text('Status')),
                    DataColumn2(label: Text('')),
                  ],
                  rows: ledgers.map((l) {
                    final retailer = retailers.firstWhere(
                      (r) => r.id == l.partyId,
                      orElse: () => Retailer(
                        id: l.partyId,
                        name: 'Retailer ${l.partyId}',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                    return DataRow(
                      cells: [
                        DataCell(Text(retailer.name)),
                        DataCell(Text('₹${l.totalAmount.toStringAsFixed(2)}')),
                        DataCell(Text('₹${l.amountPaid.toStringAsFixed(2)}')),
                        DataCell(
                          Text('₹${l.remainingAmount.toStringAsFixed(2)}'),
                        ),
                        DataCell(Text('₹${l.interest.toStringAsFixed(2)}')),
                        DataCell(Text(l.isFullyPaid ? 'Fully Paid' : 'Open')),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LedgerDetailScreen(ledger: l),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

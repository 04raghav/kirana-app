import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:kirana_app/features/ledger/ledger_detail_screen.dart';
import '../../core/providers.dart';
import '../../widgets/common_widgets.dart';
import '../../features/ledger/ledger_service.dart';
// removed unused import
import '../../database/database.dart';

class PurchasesScreen extends ConsumerStatefulWidget {
  const PurchasesScreen({super.key});

  @override
  ConsumerState<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends ConsumerState<PurchasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Purchases',
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () async {
              final report = await ref
                  .read(ledgerServiceProvider)
                  .getMigrationReport();
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Migration Report'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: report.entries
                          .map((e) => Text('${e.key}: ${e.value}'))
                          .toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Ledger>>(
        future: ref
            .read(ledgerServiceProvider)
            .getLedgersByTypeAndDate('purchase'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty) {
            return const Center(child: Text('No purchases yet'));
          }

          // Group by date
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
                      builder: (_) => PurchaseDateDetailScreen(date: date),
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

class PurchaseDateDetailScreen extends ConsumerWidget {
  final DateTime date;
  const PurchaseDateDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Purchases ${date.day}-${date.month}-${date.year}',
      ),
      body: FutureBuilder<List<Ledger>>(
        future: ref
            .read(ledgerServiceProvider)
            .getLedgersForDate(date, 'purchase'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty) {
            return const Center(child: Text('No purchases for this date'));
          }

          final wholesalersAsync = ref.watch(wholesalersListProvider);

          return wholesalersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
            data: (wholesalers) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(label: Text('Name')),
                    DataColumn2(label: Text('Total')),
                    DataColumn2(label: Text('Paid')),
                    DataColumn2(label: Text('Remaining')),
                    DataColumn2(label: Text('Interest')),
                    DataColumn2(label: Text('Status')),
                    DataColumn2(label: Text('')),
                  ],
                  rows: ledgers.map((l) {
                    final wholesaler = wholesalers.firstWhere(
                      (w) => w.id == l.partyId,
                      orElse: () => Wholesaler(
                        id: l.partyId,
                        name: 'Wholesaler ${l.partyId}',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                    return DataRow(
                      cells: [
                        DataCell(Text(wholesaler.name)),
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


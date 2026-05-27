import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(
        title: const Text('Purchases'),
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
          if (ledgers.isEmpty)
            return const Center(child: Text('No purchases yet'));

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
      appBar: AppBar(
        title: Text('Purchases ${date.day}-${date.month}-${date.year}'),
      ),
      body: FutureBuilder<List<Ledger>>(
        future: ref
            .read(ledgerServiceProvider)
            .getLedgersForDate(date, 'purchase'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty)
            return const Center(child: Text('No purchases for this date'));
          return ListView.builder(
            itemCount: ledgers.length,
            itemBuilder: (context, idx) {
              final l = ledgers[idx];
              return ListTile(
                title: Text('Wholesaler ID: ${l.partyId}'),
                subtitle: Text(
                  'Total: ₹${l.totalAmount.toStringAsFixed(2)} | Remaining: ₹${l.remainingAmount.toStringAsFixed(2)}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LedgerDetailScreen(ledger: l),
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

class LedgerDetailScreen extends ConsumerWidget {
  final Ledger ledger;
  const LedgerDetailScreen({super.key, required this.ledger});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ledger Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Party ID: ${ledger.partyId}'),
            Text('Total: ₹${ledger.totalAmount.toStringAsFixed(2)}'),
            Text('Paid: ₹${ledger.amountPaid.toStringAsFixed(2)}'),
            Text('Remaining: ₹${ledger.remainingAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                // open payment dialog
                final res = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (ctx) {
                    final amtController = TextEditingController();
                    String mode = 'Cash';
                    bool full = false;
                    return AlertDialog(
                      title: const Text('Apply Payment'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: amtController,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          DropdownButton<String>(
                            value: mode,
                            items: const [
                              DropdownMenuItem(
                                value: 'Cash',
                                child: Text('Cash'),
                              ),
                              DropdownMenuItem(
                                value: 'Cheque',
                                child: Text('Cheque'),
                              ),
                              DropdownMenuItem(
                                value: 'NEFT',
                                child: Text('NEFT'),
                              ),
                            ],
                            onChanged: (v) {
                              if (v != null) mode = v;
                            },
                          ),
                          CheckboxListTile(
                            value: full,
                            onChanged: (v) => full = v ?? false,
                            title: const Text('Mark as fully paid'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(ctx, {
                            'amount':
                                double.tryParse(amtController.text) ?? 0.0,
                            'mode': mode,
                            'full': full,
                          }),
                          child: const Text('Apply'),
                        ),
                      ],
                    );
                  },
                );

                if (res != null) {
                  await ref
                      .read(ledgerServiceProvider)
                      .applyPayment(
                        ledgerId: ledger.id,
                        amount: res['amount'],
                        paymentMode: res['mode'],
                        isFullPayment: res['full'],
                      );
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('Apply Payment'),
            ),
            const Text(
              'Breakup (items):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: ref
                    .read(ledgerServiceProvider)
                    .getLedgerBreakup(ledger.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return const Center(child: CircularProgressIndicator());
                  final rows = snapshot.data ?? [];
                  if (rows.isEmpty)
                    return const Center(child: Text('No item breakdown'));
                  return ListView.builder(
                    itemCount: rows.length,
                    itemBuilder: (context, i) {
                      final r = rows[i];
                      final itemName =
                          r['item_name'] ?? r['item_id']?.toString();
                      final wholesalerName =
                          r['wholesaler_name'] ?? r['retailer_name'];
                      final qty = r['quantity'] ?? r['quantity'];
                      final pprice =
                          r['purchase_price_at_time'] ??
                          r['purchase_price_at_time'];
                      return ListTile(
                        title: Text(itemName.toString()),
                        subtitle: Text(
                          'Source: ${wholesalerName ?? 'N/A'} | Qty: ${qty ?? 'N/A'} | Purchase: ₹${(pprice ?? 0).toString()}',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

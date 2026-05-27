import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBar(
        title: Text('Purchases ${date.day}-${date.month}-${date.year}'),
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

class LedgerDetailScreen extends ConsumerStatefulWidget {
  final Ledger ledger;
  const LedgerDetailScreen({super.key, required this.ledger});

  @override
  ConsumerState<LedgerDetailScreen> createState() => _LedgerDetailScreenState();
}

class _LedgerDetailScreenState extends ConsumerState<LedgerDetailScreen> {
  int _refreshToken = 0;

  void _refresh() {
    setState(() {
      _refreshToken++;
    });
  }

  Future<Ledger?> _ledgerFuture() {
    return ref.read(ledgerServiceProvider).getLedgerById(widget.ledger.id);
  }

  Future<List<Payment>> _paymentsFuture() {
    return ref
        .read(ledgerServiceProvider)
        .getPaymentsForLedger(widget.ledger.id);
  }

  Future<List<Map<String, dynamic>>> _breakupFuture() {
    return ref.read(ledgerServiceProvider).getLedgerBreakup(widget.ledger.id);
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.read(ledgerServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ledger Detail')),
      body: FutureBuilder<Ledger?>(
        key: ValueKey(_refreshToken),
        future: _ledgerFuture(),
        builder: (context, ledgerSnapshot) {
          if (ledgerSnapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final ledger = ledgerSnapshot.data ?? widget.ledger;
          final canApplyPayment =
              ledger.remainingAmount > 0 && !ledger.isFullyPaid;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Party ID: ${ledger.partyId}'),
                        Text(
                          'Total: ₹${ledger.totalAmount.toStringAsFixed(2)}',
                        ),
                        Text('Paid: ₹${ledger.amountPaid.toStringAsFixed(2)}'),
                        Text(
                          'Remaining: ₹${ledger.remainingAmount.toStringAsFixed(2)}',
                        ),
                        Text(
                          'Interest: ₹${ledger.interest.toStringAsFixed(2)}',
                        ),
                        Text('Mode: ${ledger.paymentMode ?? '-'}'),
                        Text(
                          'Date: ${DateFormat('dd MMM yyyy').format(ledger.date)}',
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (ledger.isFullyPaid)
                              const Chip(label: Text('Fully Paid'))
                            else
                              const Chip(label: Text('Open')),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (canApplyPayment)
                          ElevatedButton(
                            onPressed: () async {
                              final result = await showDialog<Map<String, dynamic>>(
                                context: context,
                                builder: (ctx) {
                                  final amountController =
                                      TextEditingController(
                                        text: ledger.remainingAmount
                                            .toStringAsFixed(2),
                                      );
                                  final noteController =
                                      TextEditingController();
                                  String mode = 'Cash';
                                  bool fullPayment = false;

                                  return StatefulBuilder(
                                    builder: (dialogContext, setDialogState) {
                                      return AlertDialog(
                                        title: const Text('Apply Payment'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: amountController,
                                                enabled: !fullPayment,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Amount',
                                                    ),
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                    ),
                                              ),
                                              DropdownButtonFormField<String>(
                                                initialValue: mode,
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
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setDialogState(() {
                                                      mode = value;
                                                    });
                                                  }
                                                },
                                              ),
                                              TextField(
                                                controller: noteController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Note',
                                                    ),
                                              ),
                                              CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                value: fullPayment,
                                                onChanged: (value) {
                                                  setDialogState(() {
                                                    fullPayment =
                                                        value ?? false;
                                                    if (fullPayment) {
                                                      amountController
                                                          .text = ledger
                                                          .remainingAmount
                                                          .toStringAsFixed(2);
                                                    }
                                                  });
                                                },
                                                title: const Text(
                                                  'Mark as fully paid',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(dialogContext),
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(dialogContext, {
                                                  'amount': fullPayment
                                                      ? ledger.remainingAmount
                                                      : double.tryParse(
                                                              amountController
                                                                  .text,
                                                            ) ??
                                                            0.0,
                                                  'mode': mode,
                                                  'full': fullPayment,
                                                  'note': noteController.text
                                                      .trim(),
                                                }),
                                            child: const Text('Apply'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );

                              if (result != null) {
                                await service.applyPayment(
                                  ledgerId: ledger.id,
                                  amount:
                                      (result['amount'] as num?)?.toDouble() ??
                                      0.0,
                                  paymentMode:
                                      result['mode']?.toString() ?? 'Cash',
                                  note: result['note']?.toString(),
                                  isFullPayment: result['full'] == true,
                                );
                                if (context.mounted) {
                                  showCommonSnackbar(context, 'Payment saved');
                                }
                                _refresh();
                              }
                            },
                            child: const Text('Apply Payment'),
                          )
                        else
                          const Chip(label: Text('Fully Paid')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Payment History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<Payment>>(
                  key: ValueKey('payments-$_refreshToken'),
                  future: _paymentsFuture(),
                  builder: (context, paymentsSnapshot) {
                    if (paymentsSnapshot.connectionState !=
                        ConnectionState.done) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final payments = paymentsSnapshot.data ?? [];
                    if (payments.isEmpty) {
                      return const Text('No payment history yet');
                    }

                    return Expanded(
                      child: ListView.separated(
                        itemCount: payments.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final payment = payments[index];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.payments_outlined),
                              title: Text(
                                '₹${payment.amount.toStringAsFixed(2)}',
                              ),
                              subtitle: Text(
                                [
                                  payment.paymentMode,
                                  DateFormat(
                                    'dd MMM yyyy',
                                  ).format(payment.date),
                                  if (payment.note != null &&
                                      payment.note!.trim().isNotEmpty)
                                    payment.note!,
                                ].join(' · '),
                              ),
                              trailing: payment.isFullPayment
                                  ? const Chip(label: Text('Full'))
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Breakup (items):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    key: ValueKey('breakup-$_refreshToken'),
                    future: _breakupFuture(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final rows = snapshot.data ?? [];
                      if (rows.isEmpty) {
                        return const Center(child: Text('No item breakdown'));
                      }
                      return ListView.builder(
                        itemCount: rows.length,
                        itemBuilder: (context, i) {
                          final r = rows[i];
                          final itemName =
                              r['item_name'] ?? r['item_id']?.toString();
                          final qty =
                              (r['quantity'] as num?)?.toDouble() ?? 0.0;
                          final pprice =
                              (r['purchase_price_at_time'] as num?)
                                  ?.toDouble() ??
                              0.0;
                          final sellingPrice =
                              (r['selling_price'] as num?)?.toDouble() ?? 0.0;
                          final gstRate =
                              (r['gst_rate'] as num?)?.toDouble() ?? 0.0;
                          final bardana =
                              (r['bardana'] as num?)?.toDouble() ?? 0.0;
                          final sourceRef = [
                            if (r['bill_item_source_id'] != null)
                              'BIS#${r['bill_item_source_id']}',
                            if (r['purchase_source_id'] != null)
                              'PS#${r['purchase_source_id']}',
                            if (r['inventory_id'] != null)
                              'INV#${r['inventory_id']}',
                          ].join(' · ');
                          final wholesalerName =
                              r['wholesaler_name'] ?? r['retailer_name'];
                          return ListTile(
                            title: Text(itemName.toString()),
                            subtitle: Text(
                              [
                                if (ledger.partyType == 'wholesaler' &&
                                    wholesalerName != null)
                                  'Source: $wholesalerName',
                                'Qty: ${qty.toStringAsFixed(qty == qty.roundToDouble() ? 0 : 2)}',
                                'Purchase: ₹${pprice.toStringAsFixed(2)}',
                                'Sale: ₹${sellingPrice.toStringAsFixed(2)}',
                                'GST: ${gstRate.toStringAsFixed(2)}%',
                                'Bardana: ₹${bardana.toStringAsFixed(2)}',
                                if (sourceRef.isNotEmpty)
                                  'Internal ref: $sourceRef',
                              ].join('\n'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

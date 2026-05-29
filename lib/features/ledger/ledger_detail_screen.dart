import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:kirana_app/theme/app_text_styles.dart';

import '../../core/providers.dart';
import '../../widgets/common_widgets.dart';
import '../../features/ledger/ledger_service.dart';
import '../../database/database.dart';

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
      appBar: CommonAppBar(title: 'Ledger Detail'),
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
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Party ID: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: ledger.partyId.toString(),
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '₹${ledger.totalAmount.toStringAsFixed(2)}',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Paid: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '₹${ledger.amountPaid.toStringAsFixed(2)}',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Remaining: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '₹${ledger.remainingAmount.toStringAsFixed(2)}',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Interest: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '₹${ledger.interest.toStringAsFixed(2)}',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mode: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: ledger.paymentMode ?? '-',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Date: ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: DateFormat(
                                  'dd MMM yyyy',
                                ).format(ledger.date),
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
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
                                                items:  [
                                                  DropdownMenuItem(
                                                    value: 'Cash',
                                                    child: Text('Cash',
                                                    style: AppTextStyles.body.copyWith(
                                  fontSize: 14,
                                ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'Cheque',
                                                    child: Text('Cheque',
                                                    style: AppTextStyles.body.copyWith(
                                  fontSize: 14,
                                ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'NEFT',
                                                    child: Text('NEFT',
                                                    style: AppTextStyles.body.copyWith(
                                  fontSize: 14,
                                ),
                                                    ),
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
                Text('Payment History', style: AppTextStyles.cardHeading),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: const [
                            DataColumn2(label: Text('Date')),
                            DataColumn2(label: Text('Amount')),
                            DataColumn2(label: Text('Mode')),
                            DataColumn2(label: Text('Note')),
                            DataColumn2(label: Text('Status')),
                          ],
                          rows: payments.map((payment) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    DateFormat(
                                      'dd MMM yyyy',
                                    ).format(payment.date),
                                  ),
                                ),
                                DataCell(
                                  Text('₹${payment.amount.toStringAsFixed(2)}'),
                                ),
                                DataCell(Text(payment.paymentMode)),
                                DataCell(Text(payment.note ?? '')),
                                DataCell(
                                  payment.isFullPayment
                                      ? const Chip(label: Text('Full'))
                                      : const SizedBox(),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text('Breakup (items):', style: AppTextStyles.cardHeading),
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
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 700,
                          columns: const [
                            DataColumn2(label: Text('Item')),
                            DataColumn2(label: Text('Qty')),
                            DataColumn2(label: Text('Purchase')),
                            DataColumn2(label: Text('Selling')),
                            DataColumn2(label: Text('GST')),
                            DataColumn2(label: Text('Bardana')),
                            DataColumn2(label: Text('Total')),
                          ],
                          rows: rows.map((r) {
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
                            final total = ((sellingPrice * qty) + (bardana));
                            return DataRow(
                              cells: [
                                DataCell(Text(itemName.toString())),
                                DataCell(Text(qty.toString())),
                                DataCell(Text('₹${pprice.toStringAsFixed(2)}')),
                                DataCell(
                                  Text('₹${sellingPrice.toStringAsFixed(2)}'),
                                ),
                                DataCell(
                                  Text('${gstRate.toStringAsFixed(2)}%'),
                                ),
                                DataCell(
                                  Text('₹${bardana.toStringAsFixed(2)}'),
                                ),
                                DataCell(Text('₹${total.toStringAsFixed(2)}')),
                              ],
                            );
                          }).toList(),
                        ),
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

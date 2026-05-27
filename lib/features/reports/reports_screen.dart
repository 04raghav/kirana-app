import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../services/pdf_service.dart';
import '../../widgets/common_widgets.dart';
import 'reports_service.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(billsListProvider);

    return Scaffold(
      appBar: const CommonAppBar(title: 'Reports & Backups'),
      body: billsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (bills) {
          if (bills.isEmpty) {
            return const Center(child: Text("No bills generated yet."));
          }
          return ListView.builder(
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final billData = bills[index];
              final bill = billData.bill;
              final retailer = billData.retailer;
              final cartItems = billData.items;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.receipt)),
                  title: Text('Invoice #${bill.id} - ${retailer.name}'),
                  subtitle: Text(
                    'Date: ${DateFormat("dd-MM-yyyy HH:mm").format(bill.date)}\nTotal Sale: ₹${bill.totalAmount.toStringAsFixed(2)}',
                  ),
                  isThreeLine: true,
                  trailing: ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf, size: 18),
                    label: const Text('View'),
                    onPressed: () async {
                      try {
                        await PdfService.generateAndPrintBill(
                          billId: bill.id,
                          retailer: retailer,
                          cartItems: cartItems,
                          totalAmount: bill.totalAmount,
                        );
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to generate PDF: $e'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

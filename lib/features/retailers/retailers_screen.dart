import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kirana_app/theme/app_colors.dart';
import '../../core/providers.dart';
import '../../widgets/common_widgets.dart';
import 'package:data_table_2/data_table_2.dart';
// removed unused import
import 'retailers_service.dart';

class RetailersScreen extends ConsumerWidget {
  const RetailersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final retailersAsync = ref.watch(retailersListProvider);

    return Scaffold(
      appBar: const CommonAppBar(title: 'Manage Retailers'),
      body: retailersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (retailers) {
          if (retailers.isEmpty) {
            return const Center(
              child: Text("No retailers found. Add one below."),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(label: Text('Name')),
                DataColumn2(label: Text('Phone')),
                DataColumn2(label: Text('Address')),
                DataColumn2(label: Text('')),
              ],
              rows: retailers.map((r) {
                return DataRow(
                  cells: [
                    DataCell(Text(r.name)),
                    DataCell(Text(r.phone ?? '-')),
                    DataCell(Text(r.address ?? '-')),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete, color: AppColors.error),
                        onPressed: () async {
                          await ref
                              .read(retailersServiceProvider)
                              .deleteRetailer(r.id);
                          ref.invalidate(retailersListProvider);
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRetailerDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddRetailerDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();

    showCommonDialog(
      context: context,
      title: 'Add Retailer',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(labelText: 'Address'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (nameController.text.isNotEmpty) {
              await ref
                  .read(retailersServiceProvider)
                  .addRetailer(
                    nameController.text,
                    phoneController.text.isEmpty ? null : phoneController.text,
                    addressController.text.isEmpty
                        ? null
                        : addressController.text,
                  );
              ref.invalidate(retailersListProvider);
              if (context.mounted) Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../widgets/common_widgets.dart';
import '../../theme/app_colors.dart';
import 'wholesalers_service.dart';

class WholesalersScreen extends ConsumerWidget {
  const WholesalersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wholesalersAsync = ref.watch(wholesalersListProvider);

    return Scaffold(
      appBar: const CommonAppBar(title: 'Manage Wholesalers'),
      body: wholesalersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (wholesalers) {
          if (wholesalers.isEmpty) {
            return const Center(
              child: Text("No wholesalers found. Add one below."),
            );
          }
          return ListView.builder(
            itemCount: wholesalers.length,
            itemBuilder: (context, index) {
              final w = wholesalers[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.local_shipping)),
                title: Text(w.name),
                subtitle: Text(
                  '${w.phone ?? "No phone"} | ${w.address ?? "No address"}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.error),
                  onPressed: () async {
                    try {
                      await ref
                          .read(wholesalersServiceProvider)
                          .deleteWholesaler(w.id);
                      ref.invalidate(wholesalersListProvider);
                      if (context.mounted) {
                        showCommonSnackbar(
                          context,
                          'Wholesaler deleted successfully.',
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showCommonSnackbar(
                          context,
                          'Cannot delete wholesaler related to existing inventory or transactions.',
                          isError: true,
                        );
                      }
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddWholesalerDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddWholesalerDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();

    showCommonDialog(
      context: context,
      title: 'Add Wholesaler',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            maxLength: 10,
            controller: phoneController,
            keyboardType: TextInputType.number,
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
                  .read(wholesalersServiceProvider)
                  .addWholesaler(
                    nameController.text,
                    phoneController.text.isEmpty ? null : phoneController.text,
                    addressController.text.isEmpty
                        ? null
                        : addressController.text,
                  );
              ref.invalidate(wholesalersListProvider);
              if (context.mounted) {
                showCommonSnackbar(context, 'Wholesaler added successfully.');
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

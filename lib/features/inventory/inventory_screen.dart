import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kirana_app/theme/app_colors.dart';

import '../../core/providers.dart';
import '../../database/database.dart';
import '../../widgets/common_widgets.dart';
import 'items_service.dart';
import 'purchase_sources_service.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsListProvider);

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Inventory',
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => ref.invalidate(itemsListProvider),
          ),
        ],
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No items found. Add an item first.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 700,
              columns: const [
                DataColumn2(label: Text('Item')),
                DataColumn2(label: Text('GST')),
                DataColumn2(label: Text('Bardana')),
                DataColumn2(label: Text('')),
              ],
              rows: items
                  .map(
                    (item) => DataRow(
                      cells: [
                        DataCell(Text(item.name)),
                        DataCell(Text('${item.defaultGst}%')),
                        DataCell(Text('${item.defaultBardana}')),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () =>
                                _showItemSourcesDialog(context, item),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItemDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final typeController = TextEditingController();
    final gstController = TextEditingController();
    final bardanaController = TextEditingController();

    showCommonDialog(
      context: context,
      title: 'Add Item',
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Type (e.g. Kg, Box)',
              ),
            ),
            TextField(
              controller: gstController,
              decoration: const InputDecoration(labelText: 'Default GST %'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: bardanaController,
              decoration: const InputDecoration(labelText: 'Default Bardana'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (nameController.text.trim().isEmpty) return;

            await ref
                .read(itemsServiceProvider)
                .addItem(
                  nameController.text.trim(),
                  typeController.text.trim().isEmpty
                      ? null
                      : typeController.text.trim(),
                  double.tryParse(bardanaController.text) ?? 0.0,
                  double.tryParse(gstController.text) ?? 0.0,
                );

            ref.invalidate(itemsListProvider);
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _showItemSourcesDialog(BuildContext context, Item item) async {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Expanded(child: Text('${item.name} - Purchase Sources')),
              IconButton(
                tooltip: 'Add purchase source',
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () async {
                  final wholesalers = await ref.read(
                    wholesalersListProvider.future,
                  );
                  if (dialogContext.mounted) {
                    await _showSourceEditorDialog(
                      dialogContext,
                      item,
                      wholesalers,
                    );
                  }
                },
              ),
            ],
          ),
          content: SizedBox(
            width: 760,
            child: Consumer(
              builder: (context, ref, _) {
                final sourcesAsync = ref.watch(
                  purchaseSourcesForItemProvider(item.id),
                );
                final wholesalersAsync = ref.watch(wholesalersListProvider);

                return wholesalersAsync.when(
                  loading: () => const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, stack) => Text('Error: $err'),
                  data: (wholesalers) {
                    return sourcesAsync.when(
                      loading: () => const SizedBox(
                        height: 220,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (err, stack) => Text('Error: $err'),
                      data: (sources) {
                        if (sources.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'No purchase sources added for this item.',
                            ),
                          );
                        }

                        return SizedBox(
                          height: 320,
                          child: DataTable2(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 700,
                            columns: const [
                              DataColumn2(label: Text('Wholesaler')),
                              DataColumn2(label: Text('Price')),
                              DataColumn2(label: Text('GST')),
                              DataColumn2(label: Text('Bardana')),
                              DataColumn2(label: Text('Qty')),
                              DataColumn2(label: Text('Actions')),
                            ],
                            rows: sources.map((source) {
                              final wholesalerName = _wholesalerName(
                                source.wholesalerId,
                                wholesalers,
                              );
                              return DataRow(
                                cells: [
                                  DataCell(Text(wholesalerName)),
                                  DataCell(Text('₹${source.purchasePrice}')),
                                  DataCell(Text('${source.gstRate}%')),
                                  DataCell(Text('${source.bardana}')),
                                  DataCell(
                                    Text(
                                      source.isQuantityNa
                                          ? 'N/A'
                                          : (source.quantity?.toString() ??
                                                '0'),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          tooltip: 'Edit source',
                                          icon: const Icon(Icons.edit),
                                          onPressed: () async {
                                            await _showSourceEditorDialog(
                                              dialogContext,
                                              item,
                                              wholesalers,
                                              existingSource: source,
                                            );
                                          },
                                        ),
                                        IconButton(
                                          tooltip: 'Delete source',
                                          icon: Icon(
                                            Icons.delete,
                                            color: AppColors.error,
                                          ),
                                          onPressed: () async {
                                            final confirmed =
                                                await showDialog<bool>(
                                                  context: dialogContext,
                                                  builder: (ctx) => AlertDialog(
                                                    title: const Text(
                                                      'Delete source?',
                                                    ),
                                                    content: Text(
                                                      'Remove the purchase source for $wholesalerName?',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              ctx,
                                                              false,
                                                            ),
                                                        child: const Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              ctx,
                                                              true,
                                                            ),
                                                        child: const Text(
                                                          'Delete',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );

                                            if (confirmed == true) {
                                              await ref
                                                  .read(
                                                    purchaseSourcesServiceProvider,
                                                  )
                                                  .deleteSource(source.id);
                                              ref.invalidate(
                                                purchaseSourcesForItemProvider(
                                                  item.id,
                                                ),
                                              );
                                              if (dialogContext.mounted) {
                                                showCommonSnackbar(
                                                  dialogContext,
                                                  'Purchase source deleted',
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ],
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
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSourceEditorDialog(
    BuildContext context,
    Item item,
    List<Wholesaler> wholesalers, {
    ItemPurchaseSource? existingSource,
  }) async {
    final priceController = TextEditingController(
      text: existingSource == null
          ? ''
          : existingSource.purchasePrice.toString(),
    );
    final gstController = TextEditingController(
      text: existingSource == null ? '0' : existingSource.gstRate.toString(),
    );
    final bardanaController = TextEditingController(
      text: existingSource == null ? '0' : existingSource.bardana.toString(),
    );
    final quantityController = TextEditingController(
      text: existingSource?.quantity?.toString() ?? '',
    );

    int? selectedWholesalerId = existingSource?.wholesalerId;
    bool isQuantityNa = existingSource?.isQuantityNa ?? false;

    if (selectedWholesalerId == null && wholesalers.length == 1) {
      selectedWholesalerId = wholesalers.first.id;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                existingSource == null
                    ? 'Add Purchase Source'
                    : 'Edit Purchase Source',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (existingSource == null)
                      DropdownButtonFormField<int>(
                        initialValue: selectedWholesalerId,
                        decoration: const InputDecoration(
                          labelText: 'Wholesaler',
                        ),
                        items: wholesalers
                            .map(
                              (wholesaler) => DropdownMenuItem(
                                value: wholesaler.id,
                                child: Text(wholesaler.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedWholesalerId = value;
                        }),
                      )
                    else
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Wholesaler'),
                        subtitle: Text(
                          _wholesalerName(
                            existingSource.wholesalerId,
                            wholesalers,
                          ),
                        ),
                      ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Purchase Price',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: gstController,
                      decoration: const InputDecoration(labelText: 'GST %'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: bardanaController,
                      decoration: const InputDecoration(labelText: 'Bardana'),
                      keyboardType: TextInputType.number,
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Qty N/A'),
                      value: isQuantityNa,
                      onChanged: (value) => setState(() {
                        isQuantityNa = value;
                        if (value) {
                          quantityController.clear();
                        }
                      }),
                    ),
                    TextField(
                      controller: quantityController,
                      enabled: !isQuantityNa,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final price = double.tryParse(priceController.text);
                    if (price == null || price < 0) return;
                    final gst = double.tryParse(gstController.text) ?? 0.0;
                    final bardana =
                        double.tryParse(bardanaController.text) ?? 0.0;
                    final quantity = isQuantityNa
                        ? null
                        : double.tryParse(quantityController.text);

                    if (!isQuantityNa && quantity == null) return;
                    if (existingSource == null &&
                        selectedWholesalerId == null) {
                      return;
                    }

                    final service = ref.read(purchaseSourcesServiceProvider);
                    if (existingSource == null) {
                      await service.addSource(
                        itemId: item.id,
                        wholesalerId: selectedWholesalerId!,
                        purchasePrice: price,
                        gstRate: gst,
                        bardana: bardana,
                        quantity: quantity,
                        isQuantityNa: isQuantityNa,
                      );
                    } else {
                      await service.updateSource(
                        id: existingSource.id,
                        purchasePrice: price,
                        gstRate: gst,
                        bardana: bardana,
                        quantity: quantity,
                        isQuantityNa: isQuantityNa,
                      );
                    }

                    ref.invalidate(purchaseSourcesForItemProvider(item.id));
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                      showCommonSnackbar(
                        context,
                        existingSource == null
                            ? 'Purchase source added'
                            : 'Purchase source updated',
                      );
                    }
                  },
                  child: Text(existingSource == null ? 'Add' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _wholesalerName(int wholesalerId, List<Wholesaler> wholesalers) {
    for (final wholesaler in wholesalers) {
      if (wholesaler.id == wholesalerId) {
        return wholesaler.name;
      }
    }
    return 'Wholesaler $wholesalerId';
  }
}

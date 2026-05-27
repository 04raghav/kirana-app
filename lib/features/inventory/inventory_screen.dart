import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
// removed unused imports
import 'inventory_service.dart';
import 'items_service.dart';

final availableStockProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  final service = ref.watch(inventoryServiceProvider);
  return service.getAvailableStock();
});

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory & Items'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Available Stock'),
            Tab(text: 'Item Catalog'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildStockTab(), _buildItemsTab()],
      ),
    );
  }

  Widget _buildStockTab() {
    final stockAsync = ref.watch(availableStockProvider);

    return Scaffold(
      body: stockAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (stockList) {
          if (stockList.isEmpty)
            return const Center(child: Text("No stock available."));
          return ListView.builder(
            itemCount: stockList.length,
            itemBuilder: (context, index) {
              final stock = stockList[index];
              final item = stock['item'];
              final qty = stock['totalQuantity'];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
                title: Text(item.name),
                subtitle: Text('Available Quantity: $qty'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddStockDialog(context, ref),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Receive Stock'),
      ),
    );
  }

  Widget _buildItemsTab() {
    final itemsAsync = ref.watch(itemsListProvider);

    return Scaffold(
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty)
            return const Center(child: Text("No items in catalog."));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.category)),
                title: Text(item.name),
                subtitle: Text(
                  'Type: ${item.type ?? "N/A"} | GST: ${item.defaultGst}%',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await ref.read(itemsServiceProvider).deleteItem(item.id);
                    ref.invalidate(itemsListProvider);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItemDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Catalog Item'),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final typeController = TextEditingController();
    final gstController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Catalog Item'),
        content: Column(
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
                    .read(itemsServiceProvider)
                    .addItem(
                      nameController.text,
                      typeController.text.isEmpty ? null : typeController.text,
                      0.0, // Default Bardana
                      double.tryParse(gstController.text) ?? 0.0,
                    );
                ref.invalidate(itemsListProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddStockDialog(BuildContext context, WidgetRef ref) {
    int? selectedItemId;
    int? selectedWholesalerId;
    final qtyController = TextEditingController();
    final priceController = TextEditingController();
    final bardanaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final itemsAsync = ref.watch(itemsListProvider);
            final wholesalersAsync = ref.watch(wholesalersListProvider);

            return AlertDialog(
              title: const Text('Receive Stock from Wholesaler'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Item Dropdown
                    itemsAsync.when(
                      loading: () => const CircularProgressIndicator(),
                      error: (err, _) => Text('Error: $err'),
                      data: (items) => DropdownButtonFormField<int>(
                        initialValue: selectedItemId,
                        hint: const Text('Select Item'),
                        items: items
                            .map(
                              (i) => DropdownMenuItem(
                                value: i.id,
                                child: Text(i.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => selectedItemId = v),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Wholesaler Dropdown
                    wholesalersAsync.when(
                      loading: () => const CircularProgressIndicator(),
                      error: (err, _) => Text('Error: $err'),
                      data: (ws) => DropdownButtonFormField<int>(
                        initialValue: selectedWholesalerId,
                        hint: const Text('Select Wholesaler'),
                        items: ws
                            .map(
                              (w) => DropdownMenuItem(
                                value: w.id,
                                child: Text(w.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => selectedWholesalerId = v),
                      ),
                    ),
                    TextField(
                      controller: qtyController,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Purchase Price',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: bardanaController,
                      decoration: const InputDecoration(labelText: 'Bardana'),
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
                    if (selectedItemId != null &&
                        selectedWholesalerId != null) {
                      await ref
                          .read(inventoryServiceProvider)
                          .addInwardInventory(
                            itemId: selectedItemId!,
                            wholesalerId: selectedWholesalerId!,
                            quantity:
                                double.tryParse(qtyController.text) ?? 0.0,
                            purchasePrice:
                                double.tryParse(priceController.text) ?? 0.0,
                            bardana:
                                double.tryParse(bardanaController.text) ?? 0.0,
                          );
                      ref.invalidate(availableStockProvider);
                      // Give it half a second then refresh itemsList as well just in case.
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                  child: const Text('Receive Stock'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

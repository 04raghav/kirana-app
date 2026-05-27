import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../database/database.dart';
import '../../services/pdf_service.dart';
import '../../widgets/common_widgets.dart';
import 'billing_service.dart';
import 'cart_provider.dart';

class BillingScreen extends ConsumerStatefulWidget {
  const BillingScreen({super.key});

  @override
  ConsumerState<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends ConsumerState<BillingScreen> {
  int? selectedRetailer;

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsListProvider);
    final retailersAsync = ref.watch(retailersListProvider);
    final cartItems = ref.watch(cartProvider);

    double cartTotal = cartItems.fold(0, (sum, item) => sum + item.finalTotal);

    return Scaffold(
      appBar: const CommonAppBar(title: 'Generate Bill'),
      body: Row(
        children: [
          // Left side: Item Selection
          Expanded(
            flex: 2,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Select Items to Bill',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => ref.invalidate(itemsListProvider),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: itemsAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                      data: (items) {
                        if (items.isEmpty) {
                          return const Center(
                            child: Text(
                              "No items available. Add items in inventory.",
                            ),
                          );
                        }
                        return GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return InkWell(
                              onTap: () {
                                _showAddItemDialog(context, item);
                              },
                              child: Card(
                                color: Colors.blue.shade50,
                                child: Center(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
          ),

          // Right side: Bill Cart
          Expanded(
            flex: 1,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      'Cart',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  retailersAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                    data: (retailers) {
                      return ListTile(
                        title: const Text("Select Retailer"),
                        subtitle: DropdownButton<int>(
                          isExpanded: true,
                          value: selectedRetailer,
                          hint: const Text("Choose a retailer"),
                          items: retailers.map((r) {
                            return DropdownMenuItem(
                              value: r.id,
                              child: Text(r.name),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedRetailer = val;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  Expanded(
                    child: cartItems.isEmpty
                        ? const Center(child: Text("Cart is empty"))
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cItem = cartItems[index];
                              return ListTile(
                                title: Text(cItem.item.name),
                                subtitle: Text(
                                  'Qty: ${cItem.quantity} | Total: ₹${cItem.finalTotal.toStringAsFixed(2)}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .removeItem(cItem.item.id);
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Total: ₹${cartTotal.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed:
                              (selectedRetailer == null || cartItems.isEmpty)
                              ? null
                              : () {
                                  final retailer = retailersAsync.value
                                      ?.firstWhere(
                                        (r) => r.id == selectedRetailer,
                                      );
                                  if (retailer != null) {
                                    _generateBill(
                                      retailer,
                                      cartItems,
                                      cartTotal,
                                    );
                                  }
                                },
                          child: const Text(
                            'Generate Bill',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddItemDialog(BuildContext context, Item item) async {
    final qtyController = TextEditingController(text: "1");
    final priceController = TextEditingController();

    int? selectedSourceId;

    // fetch purchase sources and wholesalers for the item (may be empty)
    final sources = await ref.read(
      purchaseSourcesForItemProvider(item.id).future,
    );
    final wholesalers = await ref.read(wholesalersListProvider.future);

    showCommonDialog(
      context: context,
      title: 'Add ${item.name} to Cart',
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sources.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: DropdownButton<int>(
                    isExpanded: true,
                    hint: const Text('Select Purchase Source (Wholesaler)'),
                    value: selectedSourceId,
                    items: sources.map((s) {
                      final qtyLabel = s.isQuantityNa
                          ? 'Qty N/A'
                          : 'Qty ${s.quantity ?? 0}';
                      final wholesalerName = wholesalers.firstWhere(
                        (w) => w.id == s.wholesalerId,
                        orElse: () => Wholesaler(
                          id: s.wholesalerId,
                          name: 'Wholesaler ${s.wholesalerId}',
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                      return DropdownMenuItem(
                        value: s.id,
                        child: Text(
                          '${wholesalerName.name} | ₹${s.purchasePrice} | GST ${s.gstRate}% | $qtyLabel',
                        ),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => selectedSourceId = v),
                  ),
                ),
              // show selected source meta
              if (selectedSourceId != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Builder(
                    builder: (ctx) {
                      final s = sources.firstWhere(
                        (x) => x.id == selectedSourceId,
                      );
                      final wholesalerName = wholesalers.firstWhere(
                        (w) => w.id == s.wholesalerId,
                        orElse: () => Wholesaler(
                          id: s.wholesalerId,
                          name: 'Wholesaler ${s.wholesalerId}',
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Source: ${wholesalerName.name}'),
                          Text('Purchase price: ₹${s.purchasePrice}'),
                          Text('GST: ${s.gstRate}%'),
                          Text('Bardana: ${s.bardana}'),
                        ],
                      );
                    },
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
                  labelText: 'Selling Price/Unit',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final qty = double.tryParse(qtyController.text) ?? 1.0;
            final price = double.tryParse(priceController.text) ?? 0.0;
            if (price > 0) {
              ref
                  .read(cartProvider.notifier)
                  .addItem(
                    item,
                    qty,
                    price,
                    purchaseSourceId: selectedSourceId,
                  );
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _generateBill(
    Retailer retailer,
    List<CartItemModel> cartItems,
    double cartTotal,
  ) async {
    final cartNotifier = ref.read(cartProvider.notifier);
    final billReqs = cartNotifier.toBillItemRequests();

    try {
      final billId = await ref
          .read(billingServiceProvider)
          .generateRetailerBill(retailerId: retailer.id, items: billReqs);

      if (mounted) {
        showCommonSnackbar(context, 'Bill generated successfully! ID: $billId');
        cartNotifier.clear();
        setState(() {
          selectedRetailer = null;
        });
      }

      await PdfService.generateAndPrintBill(
        billId: billId,
        retailer: retailer,
        cartItems: cartItems,
        totalAmount: cartTotal,
      );
    } catch (e) {
      if (mounted) {
        showCommonSnackbar(context, 'Error generating bill: $e', isError: true);
      }
    }
  }
}

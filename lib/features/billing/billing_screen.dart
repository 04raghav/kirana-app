import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kirana_app/theme/app_colors.dart';
import 'package:kirana_app/theme/app_text_styles.dart';

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
                    title: Text(
                      'Select Items to Bill',
                      style: AppTextStyles.cardHeading,
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
                                color: AppColors.cream,
                                child: Center(
                                  child: Text(
                                    item.name,
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.w700,
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
                  ListTile(
                    title: Text('Cart', style: AppTextStyles.cardHeading),
                  ),
                  const Divider(),
                  retailersAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                    data: (retailers) {
                      return ListTile(
                        title: Text(
                          "Select Retailer",
                          style: AppTextStyles.body,
                        ),
                        subtitle: DropdownButton<int>(
                          isExpanded: true,
                          value: selectedRetailer,
                          hint: const Text("Choose a retailer"),
                          items: retailers.map((r) {
                            return DropdownMenuItem(
                              value: r.id,
                              child: Text(
                                r.name,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 14,
                                ),
                              ),
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
                        ? Center(
                            child: Text(
                              "Cart is empty",
                              style: AppTextStyles.body,
                            ),
                          )
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
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.error,
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
                          child: Text('Generate Bill'),
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
    final sellingPriceController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final gstController = TextEditingController(
      text: item.defaultGst.toString(),
    );
    final bardanaController = TextEditingController(
      text: item.defaultBardana.toString(),
    );

    int? selectedSourceId;

    void applySource(ItemPurchaseSource? source) {
      selectedSourceId = source?.id;
      purchasePriceController.text = source == null
          ? ''
          : source.purchasePrice.toStringAsFixed(2);
      gstController.text = (source?.gstRate ?? item.defaultGst).toString();
      bardanaController.text = (source?.bardana ?? item.defaultBardana)
          .toString();
    }

    // fetch purchase sources and wholesalers for the item (may be empty)
    final sources = await ref.read(
      purchaseSourcesForItemProvider(item.id).future,
    );
    final wholesalers = await ref.read(wholesalersListProvider.future);

    if (!context.mounted) return;

    if (sources.isNotEmpty) {
      applySource(sources.length == 1 ? sources.first : null);
    }

    showCommonDialog(
      context: context,
      title: 'Add ${item.name} to Cart',
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: DropdownButtonFormField<int>(
                  key: ValueKey<int?>(selectedSourceId),
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: sources.isEmpty
                        ? 'Purchase Source / Wholesaler'
                        : 'Purchase Source / Wholesaler',
                  ),
                  hint: const Text('Select Purchase Source'),
                  initialValue: sources.isEmpty ? null : selectedSourceId,
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
                        style: AppTextStyles.body.copyWith(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: sources.isEmpty
                      ? null
                      : (v) => setState(() {
                          if (v == null) return;
                          final source = sources.firstWhere((s) => s.id == v);
                          applySource(source);
                          purchasePriceController.text = source.purchasePrice
                              .toStringAsFixed(2);
                          gstController.text = source.gstRate.toString();
                          bardanaController.text = source.bardana.toString();
                        }),
                ),
              ),
              if (sources.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'No purchase sources exist for this item yet.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: purchasePriceController,
                decoration: const InputDecoration(labelText: 'Purchase Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),

              TextField(
                controller: gstController,
                decoration: const InputDecoration(labelText: 'GST %'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),

              TextField(
                controller: bardanaController,
                decoration: const InputDecoration(labelText: 'Bardana'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),

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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Source: ',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: wholesalerName.name,
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
                                  text: 'Purchase price: ',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: '₹${s.purchasePrice}',
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
                                  text: 'GST: ',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: '${s.gstRate}%',
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
                                  text: 'Bardana: ',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: '${s.bardana}',
                                  style: AppTextStyles.body.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              const SizedBox(height: 8),

              TextField(
                controller: qtyController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),

              TextField(
                controller: sellingPriceController,
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
            final price = double.tryParse(sellingPriceController.text) ?? 0.0;
            final gstRate =
                double.tryParse(gstController.text) ?? item.defaultGst;
            final bardana =
                double.tryParse(bardanaController.text) ?? item.defaultBardana;
            if (price > 0) {
              ref
                  .read(cartProvider.notifier)
                  .addItem(
                    item,
                    qty,
                    price,
                    // preserve the current purchase terms in the cart row
                    // so the selected source can be traced in billing.
                    gstRate: gstRate,
                    bardana: bardana,
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

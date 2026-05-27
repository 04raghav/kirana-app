import 'package:flutter_riverpod/legacy.dart';
import '../../database/database.dart';
import 'billing_service.dart';

class CartItemModel {
  final Item item;
  final double quantity;
  final double sellingPrice;
  final double gstRate;
  final double bardana;
  final int? purchaseSourceId;

  CartItemModel({
    required this.item,
    required this.quantity,
    required this.sellingPrice,
    required this.gstRate,
    required this.bardana,
    this.purchaseSourceId,
  });

  CartItemModel copyWith({
    double? quantity,
    double? sellingPrice,
    double? gstRate,
    double? bardana,
    int? purchaseSourceId,
  }) {
    return CartItemModel(
      item: item,
      quantity: quantity ?? this.quantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      gstRate: gstRate ?? this.gstRate,
      bardana: bardana ?? this.bardana,
      purchaseSourceId: purchaseSourceId ?? this.purchaseSourceId,
    );
  }

  double get itemTotal => quantity * sellingPrice;
  double get taxValue => itemTotal * (gstRate / 100);
  double get finalTotal => itemTotal + taxValue + bardana;
}

class CartStateNotifier extends StateNotifier<List<CartItemModel>> {
  CartStateNotifier() : super([]);

  void addItem(
    Item item,
    double quantity,
    double sellingPrice, {
    double? gstRate,
    double? bardana,
    int? purchaseSourceId,
  }) {
    final existingIndex = state.indexWhere((i) => i.item.id == item.id);
    if (existingIndex >= 0) {
      final updatedCart = [...state];
      final currentItem = updatedCart[existingIndex];
      updatedCart[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + quantity,
        sellingPrice: sellingPrice,
        gstRate: gstRate,
        bardana: bardana,
        purchaseSourceId: purchaseSourceId ?? currentItem.purchaseSourceId,
      );
      state = updatedCart;
    } else {
      state = [
        ...state,
        CartItemModel(
          item: item,
          quantity: quantity,
          sellingPrice: sellingPrice,
          gstRate: gstRate ?? item.defaultGst,
          bardana: bardana ?? item.defaultBardana,
          purchaseSourceId: purchaseSourceId,
        ),
      ];
    }
  }

  void updateItemQuantity(int itemId, double newQuantity) {
    state = state.map((item) {
      if (item.item.id == itemId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
  }

  void removeItem(int itemId) {
    state = state.where((item) => item.item.id != itemId).toList();
  }

  void clear() {
    state = [];
  }

  List<BillItemRequest> toBillItemRequests() {
    return state
        .map(
          (item) => BillItemRequest(
            itemId: item.item.id,
            quantity: item.quantity,
            sellingPrice: item.sellingPrice,
            gstRate: item.gstRate,
            bardana: item.bardana,
            purchaseSourceId: item.purchaseSourceId,
          ),
        )
        .toList();
  }
}

final cartProvider =
    StateNotifierProvider<CartStateNotifier, List<CartItemModel>>((ref) {
      return CartStateNotifier();
    });

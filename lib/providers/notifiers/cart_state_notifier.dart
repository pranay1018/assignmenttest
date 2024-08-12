import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart());

  void addToCart(ProductModel product) {
    state = state.copyWith(
      items: [...state.items, product],
      totalPrice: state.totalPrice + product.price.toDouble(),
    );
  }

  // void removeFromCart(ProductModel product) {
  //   final updatedItems = List<ProductModel>.from(state.items);
  //   updatedItems.remove(product);
  //
  //   final newTotalPrice = state.totalPrice - product.price.toDouble();
  //
  //   // Ensure the total price does not go below zero
  //   state = state.copyWith(
  //     items: updatedItems,
  //     totalPrice: newTotalPrice < 0.0 ? 0.0 : newTotalPrice,
  //   );
  // }

  void removeFromCart(ProductModel product) {
    final updatedItems = List<ProductModel>.from(state.items);

    // Find the first item with the same id as the product.id and remove it
    final productIndex = updatedItems.indexWhere((item) => item.id == product.id);
    if (productIndex != -1) {
      updatedItems.removeAt(productIndex);

      // Calculate the new total price
        final newTotalPrice = state.totalPrice - product.price.toDouble();

      // Ensure the total price does not go below zero
      state = state.copyWith(
        items: updatedItems,
        totalPrice: newTotalPrice < 0 ? 0 : newTotalPrice,
      );
    }
  }
}




final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});

class Cart {
  final List<ProductModel> items;
  final double totalPrice;

  Cart({this.items = const [], this.totalPrice = 0.0});

  int get itemCount => items.length;

  Cart copyWith({List<ProductModel>? items, double? totalPrice}) {
    return Cart(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

extension PriceParsing on String {
  double toDouble() {
    // Remove any non-numeric characters (e.g., $)
    final cleanedString = this.replaceAll(RegExp(r'[^\d.]'), '');
    // Convert to double
    return double.tryParse(cleanedString) ?? 0.0;
  }
}

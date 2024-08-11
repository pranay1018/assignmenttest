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

  void removeFromCart(ProductModel product) {
    final updatedItems = List<ProductModel>.from(state.items);
    updatedItems.remove(product);
    state = state.copyWith(
      items: updatedItems,
      totalPrice: state.totalPrice - product.price.toDouble(),
    );
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

import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/notifiers/cart_state_notifier.dart';
import '../../providers/providers.dart';
import '../../utils/constants/text_strings.dart';
import '../widgets/miniCartNudge.dart';

class ProductDetailPage extends ConsumerWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetail = ref.watch(productDetailProvider(productId));
    final cartNotifier = ref.read(cartProvider.notifier);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(MyTexts.productDetails),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: productDetail.when(
        data: (product) {
          final isInCart = cart.items.any((item) => item.id == product.id);
          final quantity =
              cart.items.where((item) => item.id == product.id).length;

          return Padding(
            padding: const EdgeInsets.all(MySizes.md),
            child: ListView(
              children: [
                _buildProductImage(product.imageUrl, context),
                const SizedBox(height: MySizes.md),
                _buildProductName(product.name),
                const SizedBox(height: MySizes.sm),
                _buildProductWeight(product.weight),
                const SizedBox(height: MySizes.md),
                _buildPriceAndCartActions(
                  context,
                  product,
                  ref,
                  isInCart,
                  quantity,
                  cartNotifier,
                ),
                const SizedBox(height: MySizes.md),
                _buildProductDescription(product.description),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(cart),
    );
  }

  Widget _buildProductImage(String imageUrl, BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 2 / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      ),
    );
  }

  Widget _buildProductName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProductWeight(String weight) {
    return Text(
      weight,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildPriceAndCartActions(
      BuildContext context,
      var product,
      WidgetRef ref,
      bool isInCart,
      int quantity,
      CartNotifier cartNotifier,
      ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        isInCart
            ? Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                ref.read(cartProvider.notifier).removeFromCart(product);
              },
            ),
            Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product);
              },
            ),
          ],
        )
            : ElevatedButton(
          onPressed: () => cartNotifier.addToCart(product),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            MyTexts.addToCart,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          MyTexts.description,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: MySizes.sm),
        Text(
          description,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(Cart cart) {
    return const MiniCartNudge();
  }
}

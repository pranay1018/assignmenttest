import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:assignmenttest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../providers/notifiers/cart_state_notifier.dart';
import '../../providers/providers.dart';
import '../screens/product_detail_page.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref
        .watch(homeViewModelProvider.select((state) => state.verticalProducts));

    return productsAsyncValue.when(
      data: (products) {
        return _buildProductListWidget(products);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildProductListWidget(List<ProductModel> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Seasonal Products',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: MySizes.sm),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // Prevent nested scrolling issues
          children: products
              .map((product) => VerticalProductListCard(
                    product: product,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class VerticalProductListCard extends ConsumerWidget {
  final ProductModel product;

  const VerticalProductListCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final isInCart = cart.items.any((item) => item.id == product.id);
    final quantity = cart.items.where((item) => item.id == product.id).length;
    return Padding(
      padding: const EdgeInsets.only(bottom: MySizes.sm),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailPage(productId: product.id)),
            );
          },
          child: Row(
            children: [
              Container(
                width: 96,
                height: 96,
                margin: const EdgeInsets.all(MySizes.sm),
                // Ensure image does not touch edges
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(8.0)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall, // Uses the titleLarge style
                      ),
                      const SizedBox(height: MySizes.xs),
                      Text(product.weight,
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: MySizes.xs),
                      Text(product.price,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall), // Uses the titleLarge style
                      const Spacer(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: isInCart
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        ref
                                            .read(cartProvider.notifier)
                                            .removeFromCart(product);
                                      },
                                    ),
                                    Text(quantity.toString()),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        ref
                                            .read(cartProvider.notifier)
                                            .addToCart(product);
                                      },
                                    ),
                                  ],
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    ref.read(cartProvider.notifier).addToCart(product);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: MySizes.md),
                                    child: Text(
                                      MyTexts.addToCart,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:assignmenttest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../providers/notifiers/cart_state_notifier.dart';
import '../../providers/providers.dart';
import '../../utils/constants/colors.dart';
import '../screens/product_detail_page.dart';

class RecentlyOrderedWidget extends ConsumerWidget {
  const RecentlyOrderedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(
        homeViewModelProvider.select((state) => state.horizontalProducts));
    return productsAsyncValue.when(
      data: (products) {
        return _buildProductListWidget(products,context);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildProductListWidget(List<ProductModel> products,BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(bottom: MySizes.sm),
          child: Text(
            MyTexts.recentlyOrdered,
            style: Theme.of(context).textTheme.titleSmall, // Uses the titleLarge style
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: products
                .map((product) => ProductCard(product: product))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends ConsumerWidget {
  final ProductModel product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final isInCart = cart.items.any((item) => item.id == product.id);
    final quantity = cart.items.where((item) => item.id == product.id).length;
    return Padding(
      padding: const EdgeInsets.only(right: MySizes.sm),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.3,
        decoration: BoxDecoration(
          color: MyColors.secondary,
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
          child: Column(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8.0)),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headlineSmall, // Uses the titleLarge style
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: MySizes.xs),
                    Text(
                      product.weight,
                      style: Theme.of(context).textTheme.bodySmall, // Uses the titleLarge style
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height:MySizes.xs),
                    Text(
                      product.price,
                      style: Theme.of(context).textTheme.bodySmall, // Uses the titleLarge style
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isInCart)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        ref.read(cartProvider.notifier).removeFromCart(product);
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        ref.read(cartProvider.notifier).addToCart(product);
                      },
                    ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.green,
                  ),
                  child: const SizedBox(
                    child: Center(
                      child: Text(
                        MyTexts.addToCart,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

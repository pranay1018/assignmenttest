import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/porduct.dart';
import '../../view_model/home_view_model.dart';

class VerticalProductList extends ConsumerWidget {
  const VerticalProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(homeViewModelProvider.select((state) => state.verticalProducts));

    return productsAsyncValue.when(
      data: (products) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text('Seasonal Products', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            const SizedBox(height: 8),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling issues
              children: products.map((product) => buildVerticalProduct(product)).toList(),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget buildVerticalProduct(VerticalProductModel product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 96,
              height: 96,
              margin: const EdgeInsets.all(8.0), // Ensure image does not touch edges
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(8.0)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black)),
                    const SizedBox(height: 4),
                    Text(product.weight, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(product.price, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

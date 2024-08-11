import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/notifiers/cart_state_notifier.dart';

class MiniCartNudge extends ConsumerWidget {
  const MiniCartNudge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    if (cart.itemCount > 0) {
      return Container(
        height: 60,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items in Cart: ${cart.itemCount}'),
              Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}'),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

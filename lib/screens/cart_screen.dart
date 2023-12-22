import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/CreateBottomBar.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:ecommerce_app/widgets/rounded_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(cartProvider);
    var totalCartValue = ref.watch(cartProvider.notifier).getCartCheckoutValue();

    return Scaffold(
      drawer: const Drawer(),
      bottomNavigationBar: const CreateBottomNavigationBar(2),
      appBar: AppBar(
        actions: const [
          RoundedProfileImage(),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Text(
            "My Cart",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (items.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: items.length + 1,
                  itemBuilder: (ctx, index) {
                    if (index == items.length) {
                      return CartFooter(
                        items: items,
                        totalCartValue: totalCartValue,
                      );
                    } else {
                      return CartItemCard(items[index], index);
                    }
                  }),
            )
          else
            Text(
              "No Items Added To Cart!",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
        ],
      ),
    );
  }
}

class CartFooter extends StatelessWidget {
  const CartFooter({
    super.key,
    required this.items,
    required this.totalCartValue,
  });

  final List<CartItem> items;
  final int totalCartValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.5))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${items.length} items",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              Text(
                "\$$totalCartValue",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
          ),
          child: const Text("Checkout"),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

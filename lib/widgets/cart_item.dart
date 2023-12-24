import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class CartItemCard extends ConsumerWidget {
  const CartItemCard(this.item, this.index, {super.key});

  final int index;
  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        margin: const EdgeInsets.only(top: 20),
      ),
      onDismissed: (direction) {
        ref.read(cartProvider.notifier).removeFromCart(index);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 16, right: 20, left: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.5))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    item.item.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                Text(
                  "\$${item.item.price}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          if (int.parse(item.qty) > 1) {
                            ref.read(cartProvider.notifier).updateCartItemCount(item, "-1", index);
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
                          size: 18,
                        ),
                      ),
                    ),
                    Text(
                      item.qty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          ref.read(cartProvider.notifier).updateCartItemCount(item, "+1", index);
                        },
                        padding: const EdgeInsets.all(4),
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Size: ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      item.size,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(
                          int.parse(
                            '0xFF${item.color}'.replaceAll("#", ""),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: Hero(
                tag: item.item.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: 100,
                    // width: 100,
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(item.item.mainImage),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

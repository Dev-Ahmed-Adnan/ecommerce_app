import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/providers/favorites_provider.dart';
import 'package:ecommerce_app/screens/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeGridItem extends ConsumerWidget {
  const HomeGridItem({super.key, required this.item});
  final ItemClass item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isFav = ref.watch(favoritesProvider).contains(item);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => ItemDetails(item: item)),
        );
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(10),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.3),
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${item.price.toString()}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(favoritesProvider.notifier).updateFav(item);
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Hero(
                  tag: item.id,
                  child: FadeInImage(
                    image: NetworkImage(item.mainImage),
                    placeholder: MemoryImage(kTransparentImage),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/providers/favorites_provider.dart';
import 'package:ecommerce_app/widgets/CreateBottomBar.dart';
import 'package:ecommerce_app/widgets/home_grid_item.dart';
import 'package:ecommerce_app/widgets/rounded_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var favoritesList = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          RoundedProfileImage(),
          SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: CreateBottomNavigationBar(1),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Favorites", style: Theme.of(context).textTheme.titleLarge),
            if (favoritesList.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  itemCount: favoritesList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.35,
                  ),
                  itemBuilder: (ctx, index) => HomeGridItem(
                    item: favoritesList[index],
                  ),
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Text(
                    "No Items Added To Cart!",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
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

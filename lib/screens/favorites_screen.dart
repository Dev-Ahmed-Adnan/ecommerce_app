import 'package:ecommerce_app/providers/favorites_provider.dart';
import 'package:ecommerce_app/widgets/CreateBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var favoritesList = ref.watch(favoritesProvider);

    return const Scaffold(
      bottomNavigationBar: CreateBottomNavigationBar(1),
      body: Center(child: Text("Favorites")),
    );
  }
}

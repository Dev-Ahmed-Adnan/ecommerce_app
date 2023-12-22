import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesProviderNotifier extends StateNotifier<List<ItemClass>> {
  FavoritesProviderNotifier() : super([]);

  void updateFav(ItemClass item) {
    if (state.contains(item)) {
      state = [...state.where((element) => element.id != item.id)];
    } else {
      state = [...state, item];
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesProviderNotifier, List<ItemClass>>((ref) => FavoritesProviderNotifier());

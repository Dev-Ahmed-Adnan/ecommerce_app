import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProviderNotifier extends StateNotifier<List<ItemClass>> {
  CartProviderNotifier() : super([]);

  void updateCart(ItemClass item) {
    if (state.contains(item)) {
      state = [...state.where((element) => element.id != item.id)];
    } else {
      state = [...state, item];
    }
  }

  int getCartCheckoutValue() {
    int sum = 0;
    for (final item in state) {
      sum = sum + int.parse(item.price);
    }

    return sum;
  }
}

final cartProvider = StateNotifierProvider((ref) => CartProviderNotifier());

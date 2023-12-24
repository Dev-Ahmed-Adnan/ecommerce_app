import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProviderNotifier extends StateNotifier<List<CartItem>> {
  CartProviderNotifier() : super([]);

  void updateCart(CartItem item) {
    if (state.contains(item)) {
      state = [...state.where((element) => element.item.id != item.item.id)];
    } else {
      state = [...state, item];
    }
  }

  void addToCart(CartItem item) {
    state = [...state, item];
  }

  void removeFromCart(int index) {
    var tempList = state;
    tempList.removeAt(index);
    state = [...tempList];
  }

  void updateCartItemCount(CartItem item, String value, int index) {
    var tempList = state;

    tempList[index].upadteQty(value);
    print(index);

    state = [...tempList];
  }

  int getCartCheckoutValue() {
    int sum = 0;
    for (final item in state) {
      sum = sum + (int.parse(item.item.price) * int.parse(item.qty));
    }

    return sum;
  }
}

final cartProvider = StateNotifierProvider<CartProviderNotifier, List<CartItem>>(
  (ref) => CartProviderNotifier(),
);

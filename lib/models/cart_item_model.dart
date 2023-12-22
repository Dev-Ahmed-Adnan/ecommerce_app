import 'package:ecommerce_app/models/item_model.dart';

class CartItem {
  CartItem({
    required this.item,
    required this.qty,
    required this.color,
    required this.size,
  });

  final ItemClass item;
  String qty;
  final String color;
  final String size;

  // String updateQty(String value) {
  //   if (value == "+1") {
  //     return "${int.parse(qty) + 1}";
  //   } else {
  //     return "${int.parse(qty) - 1}";
  //   }
  // }

  void upadteQty(String value) {
    if (value == "+1") {
      qty = "${int.parse(qty) + 1}";
    } else {
      qty = "${int.parse(qty) - 1}";
    }
  }
}

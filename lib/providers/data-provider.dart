// import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataProviderNotifier extends StateNotifier<Map<String, dynamic>> {
  DataProviderNotifier()
      : super({
          "categoryList": [],
          "itemsList": [],
        });

  void addToItems(List<dynamic> items, String type) {
    state = {
      ...state,
      type: items,
    };
  }
}

final dataProvider = StateNotifierProvider<DataProviderNotifier, Map<String, dynamic>>((ref) => DataProviderNotifier());

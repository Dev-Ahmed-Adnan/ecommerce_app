import 'dart:convert';

import 'package:ecommerce_app/providers/data-provider.dart';
import 'package:ecommerce_app/widgets/category_tab_item.dart';
import 'package:ecommerce_app/widgets/home_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/utils/apis.dart';
import 'package:ecommerce_app/widgets/rounded_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<CategoryClass> categoryList = [];
  List<ItemClass> itemsList = [];
  List<ItemClass> filteredList = [];
  late CategoryClass activeTab;

  @override
  void initState() {
    super.initState();

    _getCategories();
    // _getItems();
  }

  void _getCategories() async {
    final url = Uri.parse(APIS.baseUrl + APIS().getCategories);

    final response = await http.get(url);

    if (response.body.isNotEmpty && response.statusCode < 400) {
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<CategoryClass> fetchedList = [];
      for (final item in listData.entries) {
        fetchedList.add(CategoryClass(id: item.key.toString(), title: item.value["title"]));
      }
      setState(() {
        categoryList = fetchedList;
        activeTab = fetchedList[0];
      });
      ref.read(dataProvider.notifier).addToItems(fetchedList, "categoryList");
      _getItems();
    }
  }

  void _getItems() async {
    final url = Uri.parse(APIS.baseUrl + APIS().getItems);

    final response = await http.get(url);

    if (response.body.isNotEmpty && response.statusCode < 400) {
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<ItemClass> fetchedList = [];

      for (final item in listData.entries) {
        fetchedList.add(
          ItemClass(
            id: item.key,
            title: item.value["title"],
            desc: item.value['desc'],
            category: item.value['category'],
            mainImage: item.value['mainImage'],
            price: item.value['price'].toString(),
            availableColors: item.value["availableColors"],
          ),
        );
      }

      setState(() {
        itemsList = fetchedList;
        filteredList = fetchedList.where((element) => element.category == categoryList[0].title).toList();
      });
      ref.read(dataProvider.notifier).addToItems(fetchedList, "itemsList");
    }
  }

  void _setActiveTab(CategoryClass item) {
    setState(() {
      activeTab = item;
      filteredList = itemsList.where((element) => element.category == item.title).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: const [
          RoundedProfileImage(),
          SizedBox(width: 8),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Categories", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return CategoryTabItem(
                    item: categoryList[index],
                    active: activeTab.id == categoryList[index].id,
                    onTabItemPress: (item) {
                      // setState(() {
                      //   activeTab = item;
                      // });
                      _setActiveTab(item);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: filteredList.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.35,
                      ),
                      itemCount: filteredList.length,
                      itemBuilder: (ctx, index) => HomeGridItem(
                        item: filteredList[index],
                      ),
                    )
                  : Center(
                      child: Text(
                        "No data here, Try another category.",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
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

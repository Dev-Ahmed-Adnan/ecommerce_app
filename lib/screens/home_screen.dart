import 'dart:convert';
import 'dart:math';

import 'package:ecommerce_app/providers/data-provider.dart';
import 'package:ecommerce_app/widgets/CreateBottomBar.dart';
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
  var _loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCategories());
  }

  void _getCategories() async {
    if (ref.watch(dataProvider)["categoryList"].isEmpty) {
      setState(() {
        _loading = true;
      });
      try {
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
      } catch (e) {
        print("Get category error: " + e.toString());
        setState(() {
          _loading = false;
        });
      }
    } else {
      setState(() {
        itemsList = ref.watch(dataProvider)["itemsList"];
        categoryList = ref.watch(dataProvider)['categoryList'];
        activeTab = categoryList[0];
        _setFilteredList(itemsList);
      });
    }
  }

  void _getItems() async {
    try {
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
        _setFilteredList(fetchedList);
        setState(() {
          _loading = false;
        });
        ref.read(dataProvider.notifier).addToItems(fetchedList, "itemsList");
      }
    } catch (e) {
      print("Get items error: " + e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  void _setFilteredList(List<ItemClass> items) {
    setState(() {
      itemsList = items;
      filteredList = items.where((element) => element.category == categoryList[0].title).toList();
    });
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
      bottomNavigationBar: const CreateBottomNavigationBar(0),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Categories", style: Theme.of(context).textTheme.titleLarge),
            if (_loading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            else ...[
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
          ],
        ),
      ),
    );
  }
}

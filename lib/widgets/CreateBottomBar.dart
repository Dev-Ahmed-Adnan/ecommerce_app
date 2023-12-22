import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/favorites_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CreateBottomNavigationBar extends StatefulWidget {
  const CreateBottomNavigationBar(
    this.currentIndex, {
    super.key,
  });

  final int currentIndex;

  @override
  State<CreateBottomNavigationBar> createState() => _CreateBottomNavigationBarState();
}

class _CreateBottomNavigationBarState extends State<CreateBottomNavigationBar> {
  static List<TabClass> tabList = [
    TabClass(label: "Home", screen: const HomeScreen(), icon: Icons.home),
    TabClass(label: "Favorites", screen: const FavoritesScreen(), icon: Icons.favorite_border),
    TabClass(label: "Cart", screen: const CartScreen(), icon: Icons.shopping_cart_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BottomNavigationBar(
        onTap: (index) {
          if (index != widget.currentIndex) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => tabList[index].screen),
            );
          }
        },
        currentIndex: widget.currentIndex,
        items: tabList
            .map((tab) => BottomNavigationBarItem(
                  label: tab.label,
                  icon: Icon(tab.icon),
                ))
            .toList(),
      ),
    );
  }
}

class TabClass {
  TabClass({
    required this.label,
    required this.screen,
    required this.icon,
  });

  final String label;
  final Widget screen;
  final IconData icon;
}

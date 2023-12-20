import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTabItem extends StatelessWidget {
  const CategoryTabItem({
    super.key,
    required this.item,
    required this.active,
    required this.onTabItemPress,
  });

  final CategoryClass item;
  final bool active;
  final void Function(CategoryClass item) onTabItemPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTabItemPress(item);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: active ? Colors.black : Colors.black.withOpacity(0.35),
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

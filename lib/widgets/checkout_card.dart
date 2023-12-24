import 'package:flutter/material.dart';

class CheckOutCard extends StatelessWidget {
  const CheckOutCard({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onCheck,
    required this.children,
    this.subTitle,
  });

  final String title;
  final List<Widget> children;
  final bool isChecked;
  final void Function(String item, bool value) onCheck;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onExpansionChanged: (bool expanded) {
        onCheck(title, expanded);
      },
      maintainState: true,
      controller: ExpansionTileController(),
      collapsedIconColor: Theme.of(context).colorScheme.onSecondary,
      collapsedTextColor: Theme.of(context).colorScheme.onSecondary,
      iconColor: Theme.of(context).colorScheme.onSecondary,
      trailing: children.isNotEmpty ? const Icon(Icons.keyboard_arrow_down_outlined) : Container(width: 1),

      leading: Icon(isChecked ? Icons.check_circle_rounded : Icons.circle_outlined),
      // children: if (children && children?.isNotEmpty) { return children } else  {return null},
      children: [...children],
    );
  }
}

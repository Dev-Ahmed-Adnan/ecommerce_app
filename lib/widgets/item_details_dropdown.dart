import 'package:flutter/material.dart';

class ItemDetailDropDown extends StatefulWidget {
  const ItemDetailDropDown({
    super.key,
    required this.title,
    required this.data,
    required this.selectedItem,
    required this.onSelectedItem,
    this.isColor = false,
  });

  final String title;
  final List<dynamic> data;
  final String selectedItem;
  final void Function(String value) onSelectedItem;
  final bool? isColor;

  @override
  State<ItemDetailDropDown> createState() => _ItemDetailDropDownState();
}

class _ItemDetailDropDownState extends State<ItemDetailDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
        ),
        DropdownButton(
          value: widget.selectedItem,
          items: widget.data
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: widget.isColor == true
                      ? Container(
                          width: 16,
                          height: 16,
                          margin: EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(int.parse('0xFF$e'.replaceAll("#", ""))),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 6),
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                ),
                          ),
                        ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            widget.onSelectedItem(value.toString());
          },
          // iconSize: ,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          underline: Container(
            height: 1,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          dropdownColor: Theme.of(context).colorScheme.background,
        )
      ],
    );
  }
}

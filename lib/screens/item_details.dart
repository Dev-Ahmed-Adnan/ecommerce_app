import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/widgets/item_details_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/rounded_profile_image.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.item});

  final ItemClass item;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  static List<String> sizeList = ["38", "39", "40", "41", "42"];
  static List<String> qtyList = ["1", "2", "3", "4", "5", "6", "7"];
  String _selectedSize = sizeList.first;
  String _selectedQty = qtyList.first;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.item.availableColors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          RoundedProfileImage(),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.category,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                  ),
            ),
            Text(
              widget.item.title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 10),

            //* Image SECTION:
            Hero(
              tag: widget.item.id,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.item.mainImage,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20)],
                ),

                //* DETAILS BOX SECTION:
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                      Text(
                        widget.item.desc,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                      const SizedBox(height: 10),

                      //* PRICE SECTION:
                      Row(
                        children: [
                          Text("Price",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onSecondary,
                                  )),
                          const SizedBox(width: 10),
                          Text("\$${widget.item.price}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSecondary,
                                  )),
                        ],
                      ),
                      const SizedBox(height: 10),

                      //* DROPDOWN SECTION:
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ItemDetailDropDown(
                              title: "Size",
                              data: sizeList,
                              selectedItem: _selectedSize,
                              onSelectedItem: (value) {
                                setState(() {
                                  _selectedSize = value;
                                });
                              },
                            ),
                            ItemDetailDropDown(
                              title: "Color",
                              data: widget.item.availableColors,
                              selectedItem: _selectedColor,
                              isColor: true,
                              onSelectedItem: (value) {
                                print(value);
                                setState(() {
                                  _selectedColor = value;
                                });
                              },
                            ),
                            ItemDetailDropDown(
                              title: "Qty",
                              data: qtyList,
                              selectedItem: _selectedQty,
                              onSelectedItem: (value) {
                                setState(() {
                                  _selectedQty = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      //* BUTTON SECTION:
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Add To Cart",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

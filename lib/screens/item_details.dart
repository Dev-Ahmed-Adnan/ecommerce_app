import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/item_details_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/rounded_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDetails extends ConsumerStatefulWidget {
  const ItemDetails({super.key, required this.item});

  final ItemClass item;

  @override
  ConsumerState<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends ConsumerState<ItemDetails> {
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

  void _addToCart() {
    ref.read(cartProvider.notifier).updateCart(
          CartItem(
            item: widget.item,
            qty: _selectedQty,
            color: _selectedColor,
            size: _selectedSize,
          ),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item has been added to your cart"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 500,
            stretch: true,
            toolbarHeight: 80,
            actions: const [
              RoundedProfileImage(),
              SizedBox(
                width: 10,
              )
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  widget.item.category,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                      ),
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 30),
                child: Hero(
                  tag: widget.item.id,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      widget.item.mainImage,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              // margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20)],
              ),
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
                      onPressed: () {
                        _addToCart();
                      },
                      child: Text(
                        "Add To Cart",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.only(right: 20.0, bottom: 20, left: 20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         widget.item.category,
      //         textAlign: TextAlign.left,
      //         style: Theme.of(context).textTheme.titleSmall?.copyWith(
      //               color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
      //             ),
      //       ),
      //       Text(
      //         widget.item.title,
      //         textAlign: TextAlign.left,
      //         style: Theme.of(context).textTheme.titleLarge,
      //       ),

      //       const SizedBox(height: 10),

      //       //* Image SECTION:
      //       Hero(
      //         tag: widget.item.id,
      //         child: Container(
      //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      //           clipBehavior: Clip.hardEdge,
      //           child: Image.network(
      //             widget.item.mainImage,
      //             width: double.infinity,
      //             fit: BoxFit.contain,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       Expanded(
      //         child: Container(
      //           width: double.infinity,
      //           padding: const EdgeInsets.all(16.0),
      //           decoration: BoxDecoration(
      //             color: Theme.of(context).colorScheme.secondary,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20)],
      //           ),

      //           //* DETAILS BOX SECTION:
      //           child: SingleChildScrollView(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   "Description",
      //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                         color: Theme.of(context).colorScheme.onSecondary,
      //                       ),
      //                 ),
      //                 Text(
      //                   widget.item.desc,
      //                   textAlign: TextAlign.start,
      //                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //                         color: Theme.of(context).colorScheme.onSecondary,
      //                       ),
      //                 ),
      //                 const SizedBox(height: 10),

      //                 //* PRICE SECTION:
      //                 Row(
      //                   children: [
      //                     Text("Price",
      //                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                               color: Theme.of(context).colorScheme.onSecondary,
      //                             )),
      //                     const SizedBox(width: 10),
      //                     Text("\$${widget.item.price}",
      //                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //                               color: Theme.of(context).colorScheme.onSecondary,
      //                             )),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 10),

      //                 //* DROPDOWN SECTION:
      //                 Container(
      //                   padding: const EdgeInsets.all(16),
      //                   decoration: BoxDecoration(
      //                     color: Theme.of(context).colorScheme.secondaryContainer,
      //                     borderRadius: BorderRadius.circular(20),
      //                     boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       ItemDetailDropDown(
      //                         title: "Size",
      //                         data: sizeList,
      //                         selectedItem: _selectedSize,
      //                         onSelectedItem: (value) {
      //                           setState(() {
      //                             _selectedSize = value;
      //                           });
      //                         },
      //                       ),
      //                       ItemDetailDropDown(
      //                         title: "Color",
      //                         data: widget.item.availableColors,
      //                         selectedItem: _selectedColor,
      //                         isColor: true,
      //                         onSelectedItem: (value) {
      //                           print(value);
      //                           setState(() {
      //                             _selectedColor = value;
      //                           });
      //                         },
      //                       ),
      //                       ItemDetailDropDown(
      //                         title: "Qty",
      //                         data: qtyList,
      //                         selectedItem: _selectedQty,
      //                         onSelectedItem: (value) {
      //                           setState(() {
      //                             _selectedQty = value;
      //                           });
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ),

      //                 //* BUTTON SECTION:
      //                 Container(
      //                   width: double.infinity,
      //                   margin: const EdgeInsets.only(top: 10),
      //                   child: ElevatedButton(
      //                     onPressed: () {
      //                       _addToCart();
      //                     },
      //                     child: Text(
      //                       "Add To Cart",
      //                       style: Theme.of(context).textTheme.bodyLarge,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

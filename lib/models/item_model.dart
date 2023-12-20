class ItemClass {
  ItemClass({
    required this.id,
    required this.title,
    required this.desc,
    required this.category,
    required this.mainImage,
    required this.price,
    this.listImage,
    required this.availableColors,
  });

  final String id;
  final String title;
  final String desc;
  final String price;
  final String mainImage;
  final List<String>? listImage;
  final String category;
  final List<dynamic> availableColors;
}

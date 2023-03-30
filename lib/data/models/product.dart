class Product {
  String? id;
  String title;
  String size;
  String money;
  String location;
  String? urlImage;
  String? timeCreated;
  bool? isFavourited;

  Product({
    this.id,
    required this.title,
    required this.money,
    required this.size,
    required this.location,
    this.urlImage,
    this.timeCreated,
    this.isFavourited,
  }) {
    id ??= DateTime.now().toString();
    //timeCreated ??= DateTime.now();
    isFavourited ??= false;
  }
}

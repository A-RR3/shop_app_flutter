class ProductModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int? discount;
  final String image;
  final String? name;
  final bool? inFavorites;
  final bool? inCart;
  final String? description;

  ProductModel(
      {required this.id,
      required this.price,
      required this.oldPrice,
      this.discount,
      required this.image,
      this.name,
      this.inFavorites,
      this.inCart,
      this.description});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'old_price': oldPrice,
        'discount': discount,
        'image': image,
        'name': name,
        'in_favorites': inFavorites,
        'in_cart': inCart,
        'description': description
      };
}

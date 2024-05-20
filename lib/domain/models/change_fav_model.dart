import 'dart:convert';

ChangeFavModel FavFromJson(String str) =>
    ChangeFavModel.fromJson(json.decode(str));

class ChangeFavModel {
  final bool status;
  final String message;
  // final FavoritesData? data;

  ChangeFavModel({
    required this.status,
    required this.message,
    // this.data,
  });

  factory ChangeFavModel.fromJson(Map<String, dynamic> json) => ChangeFavModel(
        status: json["status"],
        message: json["message"],
        // data:json["data"] == null ? null : FavoritesData.fromJson(json["data"]),
      );
}

// class FavoritesData {
//   final int id;
//   final ProductModel product;
//
//   FavoritesData({
//     required this.id,
//     required this.product,
//   });
//
//   factory FavoritesData.fromJson(Map<String, dynamic> json) => FavoritesData(
//         id: json["id"],
//         product: ProductModel.fromJson(json["product"]),
//       );
// }

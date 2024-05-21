import 'dart:convert';

import 'package:shop_app_flutter/domain/models/product_model.dart';

FavoriteModel welcomeFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

class FavoriteModel {
  final bool status;
  final String? message;
  final PagedFavoritesData? data;

  FavoriteModel({
    required this.status,
    this.message,
    this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : PagedFavoritesData.fromJson(json["data"]),
      );
}

class PagedFavoritesData {
  final int? currentPage;
  final List<Favorites>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  PagedFavoritesData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory PagedFavoritesData.fromJson(Map<String, dynamic> json) =>
      PagedFavoritesData(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Favorites>.from(
                json["data"]!.map((x) => Favorites.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class Favorites {
  final int id;
  final ProductModel product;

  Favorites({
    required this.id,
    required this.product,
  });

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        id: json["id"],
        product: ProductModel.fromJson(json["product"]),
      );
}

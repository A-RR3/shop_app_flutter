import 'dart:convert';

import 'package:shop_app_flutter/domain/models/product_model.dart';

SearchModel welcomeFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

class SearchModel {
  final bool status;
  final String? message;
  final PagedFavoritesData? data;

  SearchModel({
    required this.status,
    this.message,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : PagedFavoritesData.fromJson(json["data"]),
      );
}

class PagedFavoritesData {
  final int? currentPage;
  final List<ProductModel>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
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
            : List<ProductModel>.from(
                json["data"]!.map((x) => ProductModel.fromJson(x))),
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

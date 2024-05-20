import 'package:shop_app_flutter/domain/models/product_model.dart';

class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  late List<BannerModel> banners = [];
  late List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(BannerModel.fromJson(banner));
    });

    json['products'].forEach((product) {
      products.add(ProductModel.fromJson(product));
    });
  }
}

class BannerModel {
  late int id;
  late String image;

  BannerModel({required this.id, required this.image});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}

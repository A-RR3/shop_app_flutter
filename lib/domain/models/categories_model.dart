class CategoriesModel {
  final bool? status;
  final CategoriesDataModel data;

  CategoriesModel(this.status, this.data);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
        json['status'], CategoriesDataModel.fromJson(json['data']));
  }
}

class CategoriesDataModel {
  late int currentPage;
  late List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel(this.id, this.name, this.image);

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

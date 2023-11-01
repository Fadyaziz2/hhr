import 'package:equatable/equatable.dart';

class ExpenseCategoryModel extends Equatable {
  ExpenseCategoryModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  ExpenseCategoryData? data;

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryModel(
        result: json["result"],
        message: json["message"],
        data: ExpenseCategoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class ExpenseCategoryData extends Equatable {
  ExpenseCategoryData({
    this.categories,
  });

  List<Category>? categories;

  factory ExpenseCategoryData.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryData(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
  @override
  List<Object?> get props => [categories];
}

class Category extends Equatable {
  Category({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  List<Object?> get props => [id, name];
}

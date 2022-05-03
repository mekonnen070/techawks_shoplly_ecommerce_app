import 'dart:convert';

import 'package:shoplly/model/sub_category.dart';

CategoriesResult categoriesResultFromJson(String str) =>
    CategoriesResult.fromJson(json.decode(str));

String categoriesResultToJson(CategoriesResult data) =>
    json.encode(data.toJson());

class CategoriesResult {
  CategoriesResult({
    required this.categories,
  });

  List<Category> categories;

  factory CategoriesResult.fromJson(Map<String, dynamic> json) =>
      CategoriesResult(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'categories: $categories';
  }
}

class Category {
  Category(
      {required this.categoryId,
      required this.name,
      required this.subCategories});

  String categoryId;
  String name;
  List<SubCategory> subCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        name: json["name"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'categoryId: $categoryId, subCategories: $subCategories, name: $name';
  }
}

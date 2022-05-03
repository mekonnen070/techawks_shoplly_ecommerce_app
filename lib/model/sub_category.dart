class SubCategory {
    SubCategory({
        required this.categoryId,
        required this.subCategoryId,
        required this.name,
    });

    String categoryId;
    String subCategoryId;
    String name;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "name": name,
    };

      @override
  String toString() {
    return 'categoryId: $categoryId, subCategoryId: $subCategoryId, name: $name';
  }
}

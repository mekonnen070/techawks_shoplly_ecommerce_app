import 'dart:convert';

ProductsResult productsResultFromJson(String str) =>
    ProductsResult.fromJson(json.decode(str));

String productsResultToJson(ProductsResult data) => json.encode(data.toJson());

class ProductsResult {
  ProductsResult({
    required this.products,
  });

  List<Product> products;

  factory ProductsResult.fromJson(Map<String, dynamic> json) => ProductsResult(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'products: $products';
  }
}

class Product {
  Product({
    required this.productId,
    required this.name,
    required this.price,
    required this.discount,
    required this.description,
    required this.categoryId,
    required this.subCategoryId,
    required this.unitsSold,
    required this.createdAt,
    required this.images,
  });

  String productId;
  String name;
  int price;
  int discount;
  String description;
  String categoryId;
  String subCategoryId;
  int unitsSold;
  String createdAt;
  List<Image> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        name: json["name"],
        price: json["price"],
        discount: json["discount"],
        description: json["description"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        unitsSold: json["unitsSold"],
        createdAt: json["createdAt"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "price": price,
        "discount": discount,
        "description": description,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "unitsSold": unitsSold,
        "createdAt": createdAt,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "productId: $productId, name: $name,price: $price,discount: $discount,description: $description,categoryId: $categoryId,subCategoryId: $subCategoryId,unitsSold: $unitsSold,createdAt: $createdAt, images: $images";
  }
}

class Image {
  Image({
    this.url,
  });

  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };

  @override
  String toString() {
    return 'url: $url';
  }
}

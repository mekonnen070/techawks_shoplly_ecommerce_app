import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final double price;
  final bool isFavourite;
  final bool isPopular;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    required this.price,
    this.isFavourite = false,
    this.isPopular = false,
  });
  Product copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? images,
    List<Color>? colors,
    double? rating,
    double? price,
    bool? isFavourite,
    bool? isPopular,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      isFavourite: isFavourite ?? this.isFavourite,
      isPopular: isPopular ?? this.isPopular,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'colors': colors.map((x) => x.value).toList(),
      'rating': rating,
      'price': price,
      'isFavourite': isFavourite,
      'isPopular': isPopular,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      images: List<String>.from(map['images']),
      colors: List<Color>.from(map['colors']?.map((x) => Color(x))),
      rating: map['rating'],
      price: map['price'],
      isFavourite: map['isFavourite'],
      isPopular: map['isPopular'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, images: $images, colors: $colors, rating: $rating, price: $price, isFavourite: $isFavourite, isPopular: $isPopular)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.images, images) &&
        listEquals(other.colors, colors) &&
        other.rating == rating &&
        other.price == price &&
        other.isFavourite == isFavourite &&
        other.isPopular == isPopular;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        images.hashCode ^
        colors.hashCode ^
        rating.hashCode ^
        price.hashCode ^
        isFavourite.hashCode ^
        isPopular.hashCode;
  }
}

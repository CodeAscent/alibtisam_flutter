// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final List<dynamic> images;
  final List<dynamic> sizes;
  final dynamic availableStock;
  final dynamic price;
  final String category;
  final String description;
  final List<dynamic> colors;
  final String customizable;
  final List<dynamic> colorsAndSizes;

  ProductModel(
    this.id,
    this.name,
    this.images,
    this.sizes,
    this.availableStock,
    this.price,
    this.category,
    this.description,
    this.colors,
    this.customizable,
    this.colorsAndSizes,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> colors = [];
    if (json['colors'] != null) {
      if (json['colors'] is String) {
        // Decode the JSON string to a list
        colors = jsonDecode(json['colors']).where((e) => e != null).toList();
      } else {
        // It's already a list
        colors =
            (json['colors'] as List<dynamic>).where((e) => e != null).toList();
      }
    } else {
      colors = [];
    }
    return ProductModel(
      json['_id'] ?? '',
      json['name'] ?? '',
      json['images'] is String
          ? jsonDecode(json['images'])
          : json['images'] as List<dynamic>,
      json['sizes'] == null
          ? []
          : json['sizes'] is String
              ? jsonDecode(json['sizes'])
              : json['sizes'],
      json['availableStock'] ?? '',
      json['price'] ?? '0',
      json['category'] ?? '',
      json['description'] ?? '',
      colors,
      json['customizable'].toString() == "null"
          ? "false"
          : json['customizable'].toString(),
      json['colorsAndSizes'] == null
          ? []
          : json['colorsAndSizes'] is String
              ? jsonDecode(json['colorsAndSizes'])
              : json['colorsAndSizes'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'images': jsonEncode(images),
      'sizes': jsonEncode(sizes),
      'availableStock': availableStock,
      'price': price,
      'category': category,
      'description': description,
      'customizable': customizable.toString(),
      'colors': jsonEncode(colors),
      'colorsAndSizes': jsonEncode(colorsAndSizes),
    };
  }
}

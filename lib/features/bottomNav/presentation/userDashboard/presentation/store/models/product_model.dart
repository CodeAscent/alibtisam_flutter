// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final List<dynamic> images;
  final List<dynamic> sizes;
  final num availableStock;
  final num price;
  final String category;
  final String description;

  ProductModel(this.id, this.name, this.images, this.sizes, this.availableStock,
      this.price, this.category, this.description);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
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
    };
  }
}

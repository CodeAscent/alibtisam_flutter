import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/models/product_model.dart';

class CartModel {
  final String id;
  final ProductModel product;

  CartModel({required this.id, required this.product});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}

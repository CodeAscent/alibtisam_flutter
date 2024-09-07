import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/view/screens/view_product_screen.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productsViewmodel = Get.find<ProductsViewmodel>();
    final userController = Get.find<UserController>();
    return GestureDetector(
      onTap: () {
        productsViewmodel.updateSelectedProductId(product.id);
        Get.to(() => ViewProductScreen(
              product: product,
            ));
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(10),
        height: 280,
        decoration: BoxDecoration(
          color: kAppGreyColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
                width: Get.width * 0.4,
                height: 280,
                child: HttpWrapper.networkImageRequest(product.images.first)),
            SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.capitalize!,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  product.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text('Category: ' + product.category),
                SizedBox(height: 10),
                if (userController.user == null ||
                    userController.user!.role == 'EXTERNAL USER') ...[
                  Text(
                    'Price: ' + product.price.toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ],
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...product.colors.map((e) {
                      return Container(
                        height: 20,
                        width: 20,
                        color: HexColor(e),
                      );
                    }),
                  ],
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...product.sizes.map((e) {
                      return Container(
                        height: 20,
                        width: 20,
                        child: Text(
                          e,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

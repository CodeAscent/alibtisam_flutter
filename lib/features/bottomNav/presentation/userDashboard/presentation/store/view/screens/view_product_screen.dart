import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/local/database_helper.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/models/product_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/view/screens/buy_for_external_user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/view/screens/cart_screen.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/view/screens/select_groups.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProductScreen extends StatelessWidget {
  final ProductModel product;
  const ViewProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    DatabaseHelper dbHelper = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order now'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.45,
              child: CustomContainerButton(
                  onTap: () async {
                    await dbHelper.insertProduct(product);
                    customSnackbar(
                        message: 'Product added successfully in your cart');

                    //
                    // String? token = await getToken();
                    // print(userController.user!.role);
                    // if (token == null ||
                    //     userController.user!.role == 'EXTERNAL USER') {
                    //   Get.to(() => BuyForExternalUser(
                    //         product: product,
                    //       ));
                    // } else {
                    //   Get.to(() => SelectGroupsScreen());
                    // }
                  },
                  flexibleHeight: 60,
                  label: 'Add to Cart'),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: Get.width * 0.45,
              child: CustomContainerButton(
                  onTap: () async {
                    Get.to(() => CartScreen());
                  },
                  flexibleHeight: 60,
                  label: 'View Cart'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: product.images
                      .map((e) => SizedBox(
                          width: Get.width,
                          child: HttpWrapper.networkImageRequest(e)))
                      .toList(),
                  options: CarouselOptions(
                    height: 350,
                    autoPlay: true,
                  )),
              SizedBox(height: 20),
              Text(
                product.name.capitalize!,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                'stock: ' + product.availableStock.toString(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                product.price.toString() + " SAR",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                product.description,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

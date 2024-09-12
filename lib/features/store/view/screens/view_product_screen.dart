import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/store/local/database_helper.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/view/screens/buy_for_external_user.dart';
import 'package:alibtisam/features/store/view/screens/cart_screen.dart';
import 'package:alibtisam/features/store/view/screens/select_groups.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewProductScreen extends StatelessWidget {
  final ProductModel product;
  const ViewProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    DatabaseHelper dbHelper = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order now'.tr),
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
                    await dbHelper.insertOrUpdateProduct(product);
                    customSnackbar('Product added successfully in your cart'.tr,
                        ContentType.success);

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
                  label: 'Add to Cart'.tr),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: Get.width * 0.45,
              child: CustomContainerButton(
                  onTap: () async {
                    Get.to(() => CartScreen());
                  },
                  flexibleHeight: 60,
                  label: 'View Cart'.tr),
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
                'stock'.tr +' '+ product.availableStock.toString(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                product.price.toString() + " "+"sar".tr,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              if (userController.user == null ||
                  userController.user!.role == 'EXTERNAL USER') ...[
                Text(product.customizable == 'true'
                    ? 'This product is customizable with a cost of'.tr+' ${product.customizationCost}'
                    : ''),
                SizedBox(height: 10),
              ],
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

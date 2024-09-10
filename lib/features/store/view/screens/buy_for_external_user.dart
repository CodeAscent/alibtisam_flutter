import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/auth/view/screens/login.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BuyForExternalUser extends StatefulWidget {
  final List product;
  const BuyForExternalUser({
    super.key,
    required this.product,
  });

  @override
  State<BuyForExternalUser> createState() => _BuyForExternalUserState();
}

class _BuyForExternalUserState extends State<BuyForExternalUser> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
    calculateCustomizationCost();
  }

//   setPrice() {
//     setState(() {
//       price = widget.product.price * quantity;
//     });
//   }
  calculateTotalPrice() {
    num totalPrice = 0.0;
    for (var item in widget.product) {
      totalPrice += item['price'] * item['quantity'];
    }
    total = totalPrice;
    setState(() {});
  }

  calculateCustomizationCost() {
    Logger().w(widget.product);
    num totalCustomization = 0.0;
    for (var item in widget.product) {
      if (item['customization'].trim() != '') {
        Logger().w(item['customization']);

        totalCustomization += item['customizationCost'];
      }
    }
    totalCustomizationCost = totalCustomization;
    setState(() {});
  }

  num total = 0;
  num totalCustomizationCost = 0;
  final address = TextEditingController();
  final productsViewmodel = Get.find<ProductsViewmodel>();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Place Order"),
        ),
        bottomNavigationBar: Obx(
          () => CustomContainerButton(
            loading: productsViewmodel.loading.value,
            onTap: () async {
              Logger().w(widget.product);

              if (formkey.currentState!.validate()) {
                String? token = await getToken();
                if (token == null) {
                  Get.to(() => LoginScreen());
                  customSnackbar('Please login to order this product.',
                      ContentType.warning);
                } else {
                  await productsViewmodel.orderProductForExternalUser(
                    product: widget.product,
                    price: total + totalCustomizationCost,
                    deliveryAddress: address.text,
                  );
                }
              }
            },
            flexibleHeight: 60,
            label: 'Confirm',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                CustomTextField(
                  controller: address,
                  label: 'Enter Your address',
                  maxLines: 3,
                ),
                Row(
                  children: [
                    Text(
                      'Price',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    Text(total.toString() + " SAR"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Customization Cost',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    Text(totalCustomizationCost.toString() + " SAR"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Final total',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    Text((total + totalCustomizationCost).toString() + " SAR"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/models/product_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyForExternalUser extends StatefulWidget {
  final ProductModel product;
  const BuyForExternalUser({super.key, required this.product});

  @override
  State<BuyForExternalUser> createState() => _BuyForExternalUserState();
}

class _BuyForExternalUserState extends State<BuyForExternalUser> {
  int quantity = 1;
  num price = 0;
  @override
  void initState() {
    super.initState();
    setPrice();
  }

  setPrice() {
    setState(() {
      price = widget.product.price * quantity;
    });
  }

  final size = TextEditingController();
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
              if (formkey.currentState!.validate()) {
                List product = [
                  {
                    "productId": widget.product.id,
                    "quantity": quantity,
                    "size": size.text
                  }
                ];
                String? token = await getToken();
                if (token == null) {
                  customSnackbar(
                      message: 'Please login to order this product.');
                } else {
                  await productsViewmodel.orderProductForExternalUser(
                    product: product,
                    price: price,
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
                SizedBox(height: 10),
                Text(
                  'Preferred Size',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                CustomTextField(
                  controller: size,
                  label: 'Size',
                ),
                SizedBox(height: 10),
                Text(
                  'Quantity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: quantity != 1
                          ? () {
                              setState(() {
                                quantity--;
                                setPrice();
                              });
                            }
                          : () {},
                      icon: Icon(Icons.remove),
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                          setPrice();
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Total price',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Text(price.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

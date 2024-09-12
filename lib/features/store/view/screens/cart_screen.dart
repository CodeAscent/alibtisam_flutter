import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/features/auth/view/screens/login.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/store/local/database_helper.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/view/screens/buy_for_external_user.dart';
import 'package:alibtisam/features/store/view/screens/select_groups.dart';
import 'package:alibtisam/features/store/view/widgets/product_card.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final userController = Get.find<UserController>();
  String? token;
  List<int> quantities = [];
  List<TextEditingController> sizeController = [];
  List<TextEditingController> colorsController = [];
  List<TextEditingController> customizeController = [];
  List<Map<String, dynamic>> cartItems = []; // Cart items
  final productsViewmodel = Get.find<ProductsViewmodel>();
  @override
  void initState() {
    super.initState();
    checkLogin();
    initializeQuantities(); // Initialize quantities
  }

  checkLogin() async {
    token = await getToken();
    setState(() {});
  }

  void initializeQuantities() async {
    List<ProductModel> products = await databaseHelper.getProducts();
    setState(() {
      quantities = List.generate(products.length, (int index) => 1);
      sizeController = List.generate(
        products.length,
        (int index) => TextEditingController(),
      );
      colorsController = List.generate(
        products.length,
        (int index) => TextEditingController(),
      );
      customizeController = List.generate(
        products.length,
        (int index) => TextEditingController(),
      );
      // Initialize cart items list with default values

      cartItems = List.generate(
          products.length,
          (index) => {
                "productId": products[index].id,
                "quantity": 1,
                "size": "",
                "price": products[index].price,
                "customizationCost": products[index].customizationCost,
              });
      for (var items in cartItems) {
        productsViewmodel.selectedProducts.add(items['productId']);
      }
    });
  }

  void updateCartItem(int index, String productId, int quantity, String size,
      num price, String color, String customization, num customizationCost) {
    setState(() {
      cartItems[index] = {
        "productId": productId,
        "quantity": quantity,
        "size": size,
        "color": color,
        "price": price,
        "customization": customization,
        "customizationCost": customizationCost
      };
    });
  }

  num calculatePrice(ProductModel product, int quantity) {
    return product.price * quantity;
  }

  Future removeItemFromCart(int index, String productId) async {
    // Remove the product from the database
    await databaseHelper.deleteProduct(productId);
    productsViewmodel.selectedProducts.remove(productId);
    // Remove the item from the cart list
    setState(() {
      cartItems.removeAt(index);
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('cart'.tr),
        ),
        body: cartItems.length == 0
            ? Center(child: Text('Cart is Empty'.tr))
            : FutureBuilder<List<ProductModel>>(
                future: databaseHelper.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (quantities.isEmpty) {
                      quantities = List.generate(
                          snapshot.data!.length, (int index) => 1);
                      sizeController = List.generate(
                        snapshot.data!.length,
                        (int index) => TextEditingController(),
                      );
                      // Initialize cart items if not already initialized
                      cartItems = List.generate(
                          snapshot.data!.length,
                          (index) => {
                                "productId": snapshot.data![index].id,
                                "quantity": 1,
                                "size": "",
                              });
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ProductModel product = snapshot.data![index];
                        List<dynamic> colorAndSizes = product.colorsAndSizes;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductCard(product: product),
                              if (token == null ||
                                  userController.user!.role ==
                                      'EXTERNAL USER') ...[
                                SizedBox(height: 10),
                                Text(
                                  'Preferred Size'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                CustomTextField(
                                  controller: sizeController[index],
                                  label: 'size'.tr,
                                  readOnly: true,
                                  suffix: DropdownButton(
                                    underline: SizedBox(),
                                    items: colorAndSizes
                                        .map((dynamic e) =>
                                            DropdownMenuItem<dynamic>(
                                              value: e,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 60,
                                                    color: e['color'] != null
                                                        ? HexColor(e['color'])
                                                        : null,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    e['size'].toString(),
                                                    style: TextStyle(),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (dynamic val) {
                                      setState(() {
                                        sizeController[index].text =
                                            val['size'];
                                        if (val['color'] == null) {
                                          colorsController[index].text == '';
                                        } else {
                                          colorsController[index].text =
                                              val['color'];
                                        }

                                        updateCartItem(
                                          index,
                                          product.id,
                                          quantities[index],
                                          sizeController[index].text,
                                          product.price,
                                          colorsController[index].text,
                                          customizeController[index].text,
                                          product.customizationCost,
                                        );
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                if (product.customizable == 'true') ...[
                                  Text(
                                    'Customize?'.tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  CustomTextField(
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            customizeController[index].clear();
                                          });
                                          updateCartItem(
                                            index,
                                            product.id,
                                            quantities[index],
                                            sizeController[index].text,
                                            product.price,
                                            colorsController[index].text,
                                            customizeController[index].text,
                                            product.customizationCost,
                                          );
                                        },
                                        icon: Icon(Icons.cancel_rounded)),
                                    validator: (p0) {},
                                    controller: customizeController[index],
                                    label: 'Description(Optional)'.tr,
                                    onChanged: (val) {
                                      updateCartItem(
                                        index,
                                        product.id,
                                        quantities[index],
                                        sizeController[index].text,
                                        product.price,
                                        colorsController[index].text,
                                        customizeController[index].text,
                                        product.customizationCost,
                                      );
                                    },
                                  ),
                                  Text('Customization cost'.tr +
                                      ' : ' ' ${product.customizationCost}'),
                                  SizedBox(height: 10),
                                ],
                                if (colorsController[index].text != '') ...[
                                  Text(
                                    'color'.tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color:
                                        HexColor(colorsController[index].text),
                                  ),
                                ],
                                SizedBox(height: 10),
                                Text(
                                  'quantity'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: quantities[index] > 1
                                          ? () {
                                              setState(() {
                                                quantities[index]--;
                                                updateCartItem(
                                                  index,
                                                  product.id,
                                                  quantities[index],
                                                  sizeController[index].text,
                                                  product.price,
                                                  colorsController[index].text,
                                                  customizeController[index]
                                                      .text,
                                                  product.customizationCost,
                                                );
                                              });
                                            }
                                          : () async {
                                              await removeItemFromCart(
                                                  index, product.id);
                                            },
                                      icon: Icon(Icons.remove),
                                    ),
                                    Text(quantities[index].toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantities[index]++;
                                          updateCartItem(
                                            index,
                                            product.id,
                                            quantities[index],
                                            sizeController[index].text,
                                            product.price,
                                            colorsController[index].text,
                                            customizeController[index].text,
                                            product.customizationCost,
                                          );
                                        });
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'price'.tr +
                                      ' ' +
                                      'sar'.tr +
                                      ' ' +
                                      '${calculatePrice(product, quantities[index]).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                              ] else ...[
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      'Remove from cart'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await removeItemFromCart(
                                              index, product.id);
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                )
                              ]
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
        bottomNavigationBar: cartItems.length == 0
            ? SizedBox()
            : CustomContainerButton(
                onTap: () {
                  if (token == null) {
                    Get.to(() => LoginScreen());
                  } else {
                    if (formKey.currentState!.validate()) {
                      if (userController.user!.role == 'EXTERNAL USER') {
                        Get.to(() => BuyForExternalUser(
                              product: cartItems,
                            ));
                      } else {
                        Get.to(() => SelectGroupsScreen());
                      }
                    }
                  }
                },
                flexibleHeight: 60,
                label: token == null ? 'Login To Continue'.tr : 'continue'.tr,
              ),
      ),
    );
  }
}

import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/repo/products_repo.dart';
import 'package:alibtisam/features/store/view/screens/view_product_screen.dart';
import 'package:alibtisam/features/store/view/widgets/product_card.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final productsViewmodel = Get.find<ProductsViewmodel>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order History'.tr),
        ),
        body: GetBuilder<ProductsViewmodel>(initState: (state) {
          productsViewmodel.fetchOrderHistory();
        }, builder: (controller) {
          return controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ...List.generate(controller.orderRequests.length,
                            (int index) {
                          Map<String, dynamic> data =
                              controller.orderRequests[index];
                          ProductModel? res;

                          return GestureDetector(
                            onTap: () async {
                              if (userController.user!.role! == 'COACH') {
                                await controller
                                    .fetchProductById(data['productIds'].first)
                                    .then((val) {
                                  res = val;
                                });
                              } else {
                                await controller
                                    .fetchProductById(
                                        data['productIds'].first['productId'])
                                    .then((val) {
                                  res = val;
                                });
                              }
                              Get.to(() => ViewProductScreen(product: res!));
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: kAppGreyColor(),
                                  )),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('requestedBy'.tr +
                                                data['requestedBy']['name']),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'status'.tr,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    children: [
                                                  TextSpan(
                                                      text: data['status'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              data['status'] ==
                                                                      'APPROVED'
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .orange))
                                                ]))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Icon(Icons.navigate_next),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                );
        }));
  }
}

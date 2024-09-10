import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/view/screens/order_history_page.dart';
import 'package:alibtisam/features/store/view/screens/view_product_screen.dart';
import 'package:alibtisam/features/store/view/widgets/product_card.dart';
import 'package:alibtisam/features/store/viewmodel/category_viewmodel.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsTabBar extends StatefulWidget {
  const ProductsTabBar({super.key});

  @override
  State<ProductsTabBar> createState() => _ProductsTabBarState();
}

class _ProductsTabBarState extends State<ProductsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    categoryViewmodel.fetchStoreCategories();
  }

  final categoryViewmodel = Get.find<CategoryViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alibtisam Store'.tr),
          actions: [
            IconButton(
                onPressed: () async {
                  final token = await getToken();
                  if (token == null) {
                    customSnackbar(
                         'Please login to fetch your order history'.tr, ContentType.warning);
                  } else {
                    Get.to(() => OrderHistoryPage());
                  }
                },
                icon: Icon(Icons.history))
          ],
        ),
        body: GetBuilder<CategoryViewmodel>(builder: (controller) {
          return categoryViewmodel.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GetBuilder<CategoryViewmodel>(initState: (state) {
                  _tabController = TabController(
                      length: categoryViewmodel.categories.length, vsync: this);
                }, builder: (controller) {
                  return CustomTabBar(
                      tabController: _tabController,
                      customTabs: controller.categories
                          .map((e) => Text(e.name.capitalize!))
                          .toList(),
                      tabViewScreens: controller.categories
                          .map((e) => ProductsFilterByCategory(
                                categoryId: e.id,
                              ))
                          .toList());
                });
        }));
  }
}

class ProductsFilterByCategory extends StatelessWidget {
  final String categoryId;
  const ProductsFilterByCategory({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final productsViewmodel = Get.find<ProductsViewmodel>();

    return GetBuilder<ProductsViewmodel>(initState: (state) {
      productsViewmodel.fetchProducts(categoryId);
    }, builder: (controller) {
      return controller.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                ProductModel product = controller.products[index];
                return ProductCard(product: product);
              },
            );
    });
  }
}

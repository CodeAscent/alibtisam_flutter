import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/models/product_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/view/screens/view_product_screen.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/viewmodel/category_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachStore extends StatefulWidget {
  const CoachStore({super.key});

  @override
  State<CoachStore> createState() => _CoachStoreState();
}

class _CoachStoreState extends State<CoachStore>
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
          title: Text('Alibtisam Store'),
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
                                categoryId:
                                 e.id,
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
                return GestureDetector(
                  onTap: () {
                    controller.updateSelectedProductId(product.id);
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
                            child: HttpWrapper.networkImageRequest(
                                product.images.first)),
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
                            Text('Price: ' + product.price.toString()),
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}

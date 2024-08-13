import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/models/product_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/repo/products_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logger/web.dart';

class ProductsViewmodel extends GetxController {
  RxBool loading = false.obs;
  ProductsRepo productsRepo = ProductsRepo();
  List<ProductModel> products = [];
  RxString selectedProductId = ''.obs;
  Future fetchProducts(String categoryId) async {
    try {
      loading.value = true;
      final res = await productsRepo.fetchProducts(categoryId);
      Logger().w(res);
      products = List<ProductModel>.from(
          res['data'].map((e) => ProductModel.fromJson(e)));
      loading.value = false;

      update();
      return products;
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }

  updateSelectedProductId(String productId) {
    selectedProductId.value = productId;
    update();
  }

  orderProducts({required List<dynamic> playerIds}) async {
    try {
      loading.value = true;
      final res = await productsRepo.orderProduct(playerIds: playerIds);
      loading.value = false;

      update();
      Get.back();
      Get.back();
      customSnackbar(message: res['message']);
      return products;
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }
}

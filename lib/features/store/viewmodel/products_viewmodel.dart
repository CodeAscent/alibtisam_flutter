import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/store/local/database_helper.dart';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:alibtisam/features/store/repo/products_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logger/web.dart';

class ProductsViewmodel extends GetxController {
  RxBool loading = false.obs;
  ProductsRepo productsRepo = ProductsRepo();
  List<ProductModel> products = [];
  List<dynamic> orderRequests = [];
  RxString selectedProductId = ''.obs;
  List<dynamic> selectedProducts = [];
  Future fetchProducts(String categoryId) async {
    try {
      loading.value = true;
      final res = await productsRepo.fetchProducts(categoryId);
      Logger().w(res);
      products = List<ProductModel>.from(
          res['data'].map((e) => ProductModel.fromJson(e)));

      return products;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;
      update();
    }
  }

  clearSelectedProducts() {
    selectedProducts.clear();
    update();
  }

  Future<ProductModel?> fetchProductById(String id) async {
    try {
      loading.value = true;
      final res = await productsRepo.fetchProductById(id);
      ProductModel product = ProductModel.fromJson(res['data']);
      return product;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;
      update();
    }
    return null;
  }

  Future fetchOrderHistory() async {
    try {
      loading.value = true;
      final res = await productsRepo.orderHistory();
      loading.value = false;
      update();
      orderRequests = res['requests'];

      return orderRequests;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;
      update();
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
      await DatabaseHelper().clearCart();

      Get.back();
      Get.back();
      Get.back();
      customSnackbar(res['message'], ContentType.success);
      return products;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;
      update();
    }
  }

  orderProductForExternalUser(
      {required List<dynamic> product,
      required num price,
      required String deliveryAddress}) async {
    try {
      loading.value = true;
      final res = await productsRepo.orderProductForExternal(
          productIds: product, price: price, deliveryAddress: deliveryAddress);

      customSnackbar(res['message'], ContentType.success);
      return products;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;

      update();
    }
  }
}

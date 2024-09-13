import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/store/local/database_helper.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class ProductsRepo {
  final userController = Get.find<UserController>();
  fetchProducts(String categoryId) async {
    try {
      final role = userController.user == null ||
              userController.user!.role == 'EXTERNAL USER'
          ? 'EXTERNAL'
          : 'INTERNAL';
      String endpoint = 'product/all?role=$role';
      if (categoryId != '1') {
        endpoint = 'product/all?role=$role&categoryId=$categoryId';
      }
      final res = await HttpWrapper.getRequest(base_url + endpoint);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException(data['message']);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  fetchProductById(String id) async {
    try {
      String endpoint = 'product/get/66c87b1edfd99015192a9956';

      final res = await HttpWrapper.getRequest(base_url + endpoint);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Logger().f(data);

        return data;
      } else {
        throw ServerException(data['message']);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  orderProduct({required List<dynamic> playerIds}) async {
    try {
      final productsViewmodel = Get.find<ProductsViewmodel>();
      final userController = Get.find<UserController>();
      Logger().w(productsViewmodel.selectedProducts);
      final res = await HttpWrapper.postRequest(
          base_url + 'request/buy-product-for-player', {
        "playerIds": playerIds,
        "productIds": productsViewmodel.selectedProducts,
        "coachId": userController.user!.id,
      });
      productsViewmodel.clearSelectedProducts();
      Logger().w(productsViewmodel.selectedProducts);

      final data = jsonDecode(res.body);
      Logger().f(data);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException(data['message']);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  orderProductForExternal(
      {required List<dynamic> productIds,
      required num price,
      required String deliveryAddress}) async {
    try {
      final res =
          await HttpWrapper.postRequest(base_url + 'request/order-product', {
        "productIds": productIds,
        "deliveryAddress": deliveryAddress,
        "totalAmount": price,
      });
      final data = jsonDecode(res.body);
      Logger().f(data);
      await DatabaseHelper().clearCart();

      if (res.statusCode == 200) {
        Get.back();
        Get.back();
        return data;
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  orderHistory() async {
    try {
      String endpoint = userController.user!.role == 'COACH'
          ? "request/by-user/all?kind=buyPlayerProductRequest"
          : "request/by-user/all?kind=externalUserOrderRequest";
      final res = await HttpWrapper.getRequest(base_url + endpoint);
      final data = jsonDecode(res.body);
      Logger().f(data);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException(data['message']);
      }
    } catch (e) {}
  }
}

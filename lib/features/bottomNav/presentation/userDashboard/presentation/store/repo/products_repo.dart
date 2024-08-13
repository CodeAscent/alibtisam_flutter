import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/viewmodel/products_viewmodel.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class ProductsRepo {
  fetchProducts(String categoryId) async {
    try {
      String endpoint = 'product/all';
      if (categoryId != '1') {
        endpoint = 'product/all?categoryId=$categoryId';
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

  orderProduct({required List<dynamic> playerIds}) async {
    try {
      final productsViewmodel = Get.find<ProductsViewmodel>();
      final userController = Get.find<UserController>();
      final res = await HttpWrapper.postRequest(
          base_url + 'request/buy-product-for-player', {
        "playerIds": playerIds,
        "productIds": [productsViewmodel.selectedProductId.value],
        "coachId": userController.user!.id
      });
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
}

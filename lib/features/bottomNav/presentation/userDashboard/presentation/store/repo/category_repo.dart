import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';

class CategoryRepo {
  

  fetchStoreCategories()async{
    try {
      final res = await HttpWrapper.getRequest(base_url + 'category/dropdown');
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
}
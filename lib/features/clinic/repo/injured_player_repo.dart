import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';

class InjuredPlayerRepo {
  Future getInjuredPlayers() async {
    try {
      final res =
          await HttpWrapper.getRequest(base_url + 'monitoring/get-injured');

      final data = jsonDecode(res.body);

      return data;
    } catch (e) {
      rethrow;
    }
  }
}

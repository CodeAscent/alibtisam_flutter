import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:http/http.dart' as http;

class SportsRepo {
  Future getClubSports() async {
    try {
      final res = await HttpWrapper.getRequest(base_url + 'game/all');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw Exception([data['message']]);
      }
    } catch (e) {
      rethrow;
    }
  }
}

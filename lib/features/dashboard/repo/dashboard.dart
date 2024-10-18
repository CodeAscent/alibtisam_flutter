import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/features/dashboard/models/dashboard.dart';

class DashboardRepo {
    Future<List<DashboardModel>> getDashboardItems() async {
    try {
      List<DashboardModel> dashboardItems = [];
      final res = await HttpWrapper.getRequest(get_dashboard_services);
      final data = jsonDecode(res.body);
      for (var item in data['services']) {
        dashboardItems.add(DashboardModel.fromMap(item));
      }
      return dashboardItems;
    }  catch (e) {
     throw e.toString();
    }
    
  }
}
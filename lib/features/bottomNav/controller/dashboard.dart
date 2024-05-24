import 'package:alibtisam_flutter/features/bottomNav/model/dashboard.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<DashboardModel> dashboard = [];

  Future fetchDashboardItems() async {
    dashboard = [];
    dashboard = await ApiRequests().getDashboardItems();
    update();
  }
}

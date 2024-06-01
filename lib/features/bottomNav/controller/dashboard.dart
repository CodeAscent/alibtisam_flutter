import 'package:SNP/features/bottomNav/model/dashboard.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<DashboardModel> dashboard = [];

  Future fetchDashboardItems() async {
    dashboard = [];
    dashboard = await ApiRequests().getDashboardItems();
    update();
  }
}

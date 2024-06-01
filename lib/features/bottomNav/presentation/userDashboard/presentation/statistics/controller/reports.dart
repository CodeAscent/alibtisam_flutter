import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/model/monitoring.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  List<MonitoringModel?> reports = [];

  fetchReports() async {
    reports = await ApiRequests().getReportsByPlayerId();
    update();
  }
}

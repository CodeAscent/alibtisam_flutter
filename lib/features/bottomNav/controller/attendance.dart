import 'package:SNP/features/bottomNav/model/attendance.dart';
import 'package:SNP/features/bottomNav/model/attendance_history.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance/attendance_history_list.dart';
import 'package:SNP/helper/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:SNP/network/api_urls.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class AttendanceController extends GetxController {
  List<AttendanceModel> attendance = [];
  List<AttendanceHistoryModel> attendancesHistory = [];
  String attendanceId = '';
  fetchAttendance({required String teamId}) async {
    attendance.clear();
    update();
    LoadingManager.startLoading();
    final res = await ApiRequests().addAttendance(teamId: teamId);
    attendance = res["attendance"];
    attendanceId = res['attendanceId'];
    update();
  }

  fetchIntimeAttendance() async {
    attendance.clear();
    LoadingManager.startLoading();

    final res = await ApiRequests()
        .getMarkedIntimeAttendance(attendanceId: attendanceId);
    print('-------------> $res');
    attendance = res["attendance"];
    update();
  }

  fetchCompletedAttendance() async {
    attendance.clear();
    LoadingManager.startLoading();

    final res =
        await ApiRequests().getCompletedAttendance(attendanceId: attendanceId);
    print('-------------> $res');
    attendance = res["attendance"];
    update();
  }

  fetchAttAttendanceHistory() async {
    attendancesHistory.clear();
    LoadingManager.startLoading();
    print("---------------->${attendancesHistory}");

    attendancesHistory = await ApiRequests().getAllCompletedAttendanceByCoach();
    print("---------------->${attendancesHistory}");

    update();
  }
}

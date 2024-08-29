import 'package:alibtisam/features/attendance/models/attendance.dart';
import 'package:alibtisam/features/attendance/models/attendance_history.dart';
import 'package:alibtisam/features/attendance/models/attendance_statistics.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  List<AttendanceModel> attendance = [];
  AttendanceStatisticsModel? attendanceStatistics;
  List<AttendanceHistoryModel> attendancesHistory = [];
  String attendanceId = '';

  clearAttendanceId() {
    attendanceId = '';
    update();
  }

  fetchAttendanceForInTime({required String groupId}) async {
    attendance.clear();
    update();
    final res = await ApiRequests().getAttendanceForInTime(groupId: groupId);
    attendance = res["attendance"];
    attendanceId = res['attendanceId'];
    update();
  }

  fetchAttendanceForOutTime() async {
    attendance.clear();

    final res = await ApiRequests().getAttendanceForOutTime(
      attendanceId: attendanceId,
    );
    attendance = res["attendance"];
    update();
  }

  fetchSingleAttendanceById() async {
    attendance.clear();
    final res =
        await ApiRequests().getSingleAttendanceById(attendanceId: attendanceId);
    attendance = res["attendance"];
    update();
  }

  fetchAttendanceHistory({required String groupId}) async {
    attendancesHistory =
        (await ApiRequests().getAttendanceHistory(groupId: groupId))!;
    update();
  }

  fetchAttendanceHistoryByPlayer() async {
    attendancesHistory.clear();
    print('--------------> here');
    attendancesHistory = await ApiRequests().getPlayerAttendanceHistory();
    update();
  }

  fetchPlayerAttendanceStatistics() async {
    attendanceStatistics =
        (await ApiRequests().getPlayerAttendanceStatistics())!;
    update();
  }
}

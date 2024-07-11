import 'package:alibtisam/features/bottomNav/model/attendance.dart';
import 'package:alibtisam/features/bottomNav/model/attendance_history.dart';
import 'package:alibtisam/features/bottomNav/model/attendance_statistics.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  List<AttendanceModel> attendance = [];
  AttendanceStatisticsModel? attendanceStatistics;
  List<AttendanceHistoryModel> attendancesHistory = [];
  String attendanceId = '';
  String currentStage = '';

  clearAttendanceId() {
    attendanceId = '';
    update();
  }

  fetchAttendanceForInTime({required String ageCategoryId}) async {
    attendance.clear();
    update();
    LoadingManager.startLoading();
    final res = await ApiRequests().getAttendanceForInTime(
        ageCategoryId: ageCategoryId, stage: currentStage);
    attendance = res["attendance"];
    attendanceId = res['attendanceId'];
    update();
  }

  fetchAttendanceForOutTime() async {
    attendance.clear();

    LoadingManager.startLoading();
    final res = await ApiRequests().getAttendanceForOutTime(
      attendanceId: attendanceId,
    );
    attendance = res["attendance"];
    update();
  }

  fetchSingleAttendanceById() async {
    attendance.clear();
    LoadingManager.startLoading();
    final res =
        await ApiRequests().getSingleAttendanceById(attendanceId: attendanceId);
    attendance = res["attendance"];
    update();
  }

  fetchAttendanceHistoryListByCoach() async {
    LoadingManager.startLoading();
    attendancesHistory = (await ApiRequests()
        .getAttendanceHistoryListByCoach(stage: currentStage))!;
    update();
  }

  fetchAttendanceHistoryByPlayer() async {
    attendancesHistory.clear();
    print('--------------> here');
    LoadingManager.startLoading();
    attendancesHistory = await ApiRequests().getPlayerAttendanceHistory();
    update();
  }

  fetchPlayerAttendanceStatistics() async {
    LoadingManager.startLoading();
    attendanceStatistics =
        (await ApiRequests().getPlayerAttendanceStatistics())!;
    update();
  }
}

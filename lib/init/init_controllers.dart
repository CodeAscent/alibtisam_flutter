import 'package:SNP/client/socket_io.dart';
import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/controller/chat_messages.dart';
import 'package:SNP/features/bottomNav/controller/chats_list.dart';
import 'package:SNP/features/bottomNav/controller/dashboard.dart';
import 'package:SNP/features/bottomNav/controller/date_range.dart';
import 'package:SNP/features/bottomNav/controller/games.dart';
import 'package:SNP/features/bottomNav/controller/measurement_req.dart';
import 'package:SNP/features/bottomNav/controller/selected_player.dart';
import 'package:SNP/features/bottomNav/controller/teams.dart';
import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/presentation/settings/controller/organization.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/reports.dart';
import 'package:SNP/helper/theme/controller/theme_controller.dart';
import 'package:SNP/helper/common/controller/custom_loading_controller.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:get/get.dart';

initControllers() {
  Get.put(ActivePlayerController());
  Get.put(EventNavigation());
  Get.put(CustomLoadingController());
  Get.put(ThemeController());
  Get.put(UserController());
  Get.put(DashboardController());
  Get.put(MeasurementReqController());
  Get.put(ChatMessagesController());
  Get.put(ChatsListController());
  Get.put(MonitoringController());
  Get.put(OrganizationController());
  Get.put(GamesController());
  Get.put(ReportsController());
  Get.put(TeamsController());
  Get.put(SelectedPlayerController());
  Get.put(AttendanceController());
  Get.put(DateRangeController());
}

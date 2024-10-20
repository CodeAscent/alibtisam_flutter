import 'package:alibtisam/client/socket_io.dart';
import 'package:alibtisam/features/alRwaadClub/repo/alrwaad_repo.dart';
import 'package:alibtisam/features/alRwaadClub/viewModel/alrwaad_viewmodel.dart';
import 'package:alibtisam/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/chat/controller/chat_messages.dart';
import 'package:alibtisam/features/bottomNav/controller/chats_list.dart';
import 'package:alibtisam/features/clinic/repo/clinic_appointment_repo.dart';
import 'package:alibtisam/features/clinic/viewmodel/clinic_appointment_viewmodel.dart';
import 'package:alibtisam/features/enrollment/viewmodel/enrollment_viewmodel.dart';
import 'package:alibtisam/features/groupsManagement/data/repository/groups_members_repo_impl.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/group_members_view_model.dart';
import 'package:alibtisam/features/sessionAppointment/repo/session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:alibtisam/features/sports/repo/sports_repo.dart';
import 'package:alibtisam/features/sports/viewmodel/sports_viewmodel.dart';
import 'package:alibtisam/features/dashboard/viewmodel/dashboard.dart';
import 'package:alibtisam/features/bottomNav/controller/date_range.dart';
import 'package:alibtisam/features/bottomNav/controller/games.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/measurement_req.dart';
import 'package:alibtisam/features/bottomNav/controller/selected_player.dart';
import 'package:alibtisam/features/bottomNav/controller/teams.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/settings/controller/change_password_viewmodel.dart';
import 'package:alibtisam/features/settings/controller/organization.dart';
import 'package:alibtisam/features/events/controller/active_player.dart';
import 'package:alibtisam/features/playerPolarization/controller/fetch_players.dart';
import 'package:alibtisam/features/statistics/controller/monitoring.dart';
import 'package:alibtisam/features/statistics/controller/reports.dart';
import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:alibtisam/features/events/controller/event_navigation.dart';
import 'package:alibtisam/features/store/viewmodel/category_viewmodel.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:alibtisam/features/tournamentRequest/viewmodel/tournament_request_viewmodel.dart';
import 'package:alibtisam/features/trainingPlan/viewModel/training_plan_viewmodel.dart';
import 'package:alibtisam/service_locator.dart';
import 'package:get/get.dart';

initControllers() {
  Get.put(ActivePlayerController());
  Get.put(EventNavigation());
  Get.put(ThemeController());
  Get.put(UserController());
  Get.put(serviceLocator<DashboardViewModel>());
  Get.put(serviceLocator<EnrollmentViewmodel>());
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
  Get.put(GroupsController());
  Get.put(PlayerPolarizationController());
  Get.put(serviceLocator<AuthViewmodel>());
  Get.put(TournamentRequestViewmodel());
  Get.put(ChangePasswordViewmodel());
  Get.put(CategoryViewmodel());
  Get.put(ProductsViewmodel());
  Get.put(TrainingPlanViewmodel());
  Get.put(GroupMembersViewModel(GroupsMembersRepoImplementation()));
  Get.put(AlrwaadViewmodel(AlrwaadRepo()));
  Get.put(SocketConnection());
  Get.put(SportsViewmodel(SportsRepo()));
  Get.put(SessionAppointmentViewmodel(SessionAppointmentRepo()));
  Get.put(ClinicAppointmentViewmodel(
      clinicAppointmentRepo: ClinicAppointmentRepo()));
}

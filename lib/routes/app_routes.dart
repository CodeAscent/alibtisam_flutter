import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/chat_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/enrollment/enrollment_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/presentation/events.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/attendance_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/collection/collection.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/groupsManagement/groups_management.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/loanApplication/loan_application.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/playerRequests/request_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/playerPolarization/player_polarization.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/training_plan_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/sessionAppointment/session_appointment.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/sports/sports_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/coach_player_monitoring.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/statistics_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/store_navigation.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/tournament_request.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? pages = [
  GetPage(name: '/allEvents', page: () => AllEvents()),
  GetPage(name: '/sports', page: () => SportsNavigation()),
  GetPage(name: '/statistics', page: () => StatisticsNavigation()),
  GetPage(name: '/attendance', page: () => AttendanceNavigation()),
  GetPage(name: '/practice', page: () => TrainingPlanNavigation()),
  GetPage(name: '/store', page: () => StoreNavigation()),
  GetPage(name: '/requestPortal', page: () => PlayerRequestsTabBar()),
  GetPage(name: '/sessionAppointment', page: () => SessionAppointment()),
  GetPage(name: '/loan', page: () => LoanApplication()),
  GetPage(name: '/enroll', page: () => EnrollmentNavigation()),
  GetPage(name: '/collection', page: () => CollectionScreen()),
  GetPage(name: '/groupManagement', page: () => GroupsManagement()),
  GetPage(name: '/playerPolarization', page: () => PlayerPolarization()),
  GetPage(name: '/tournamentRequest', page: () => TournamentRequest()),
  GetPage(name: '/coachMonitering', page: () => CoachPlayerMonitering()),
  GetPage(name: '/chat', page: () => ChatNavigation()),
];

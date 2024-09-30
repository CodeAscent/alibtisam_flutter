import 'package:alibtisam/features/alRwaadClub/view/screens/alrwaad_registration.dart';
import 'package:alibtisam/features/alRwaadClub/view/screens/alrwaad_services.dart';
import 'package:alibtisam/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam/features/chat/presentation/chat.dart';
import 'package:alibtisam/features/chat/presentation/chat_navigation.dart';
import 'package:alibtisam/features/enrollment/enrollment_navigation.dart';
import 'package:alibtisam/features/events/presentation/events.dart';
import 'package:alibtisam/features/attendance/attendance_navigation.dart';
import 'package:alibtisam/features/collection/collection.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/groups_management.dart';
import 'package:alibtisam/features/loanApplication/loan_application.dart';
import 'package:alibtisam/features/playerRequests/request_tab_bar.dart';
import 'package:alibtisam/features/playerPolarization/player_polarization.dart';
import 'package:alibtisam/features/trainingPlan/training_plan_navigation.dart';
import 'package:alibtisam/features/sessionAppointment/session_appointment.dart';
import 'package:alibtisam/features/sports/sports_navigation.dart';
import 'package:alibtisam/features/statistics/coach/presentation/monitoring/coach_player_monitoring.dart';
import 'package:alibtisam/features/statistics/statistics_navigation.dart';
import 'package:alibtisam/features/store/store_navigation.dart';
import 'package:alibtisam/features/tournamentRequest/view/screens/tournaments.dart';
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
  GetPage(name: '/tournamentRequest', page: () => TournamentsScreen()),
  GetPage(name: '/coachMonitering', page: () => CoachPlayerMonitering()),
  GetPage(name: '/chat', page: () => ChatNavigation()),
  GetPage(name: '/alRwaad', page: () => AlrwaadServices()),
  GetPage(name: '/bottomNav', page: () => BottomNav()),
];

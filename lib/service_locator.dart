import 'package:alibtisam/features/auth/repo/auth_repo.dart';
import 'package:alibtisam/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:alibtisam/features/userDashboard/repo/dashboard.dart';
import 'package:alibtisam/features/userDashboard/viewmodel/dashboard.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

initServiceLocator() {
  serviceLocator
    ..registerLazySingleton(() => DashboardRepo())
    ..registerFactory(() => DashboardViewModel(serviceLocator()))
    ..registerLazySingleton(() => AuthRepo())
    ..registerLazySingleton(() => AuthViewmodel(serviceLocator()));
}

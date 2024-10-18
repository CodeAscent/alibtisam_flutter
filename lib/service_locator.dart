import 'package:alibtisam/features/auth/repo/auth_repo.dart';
import 'package:alibtisam/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:alibtisam/features/enrollment/repo/enrollment_repo.dart';
import 'package:alibtisam/features/enrollment/viewmodel/enrollment_viewmodel.dart';
import 'package:alibtisam/features/dashboard/repo/dashboard.dart';
import 'package:alibtisam/features/dashboard/viewmodel/dashboard.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

initServiceLocator() {
  serviceLocator
    ..registerLazySingleton(() => DashboardRepo())
    ..registerFactory(() => DashboardViewModel(serviceLocator()))
    ..registerLazySingleton(() => AuthRepo())
    ..registerFactory(() => AuthViewmodel(serviceLocator()))
    ..registerLazySingleton(() => EnrollmentRepo())
    ..registerFactory(() => EnrollmentViewmodel(serviceLocator()));
}

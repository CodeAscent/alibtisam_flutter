import 'package:alibtisam_flutter/features/commons/home/custom_bottom_nav.dart';
import 'package:alibtisam_flutter/features/commons/dummySplash/dummy_splash.dart';
import 'package:alibtisam_flutter/helper/theme/app_theme.dart';
import 'package:alibtisam_flutter/init/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

void main() async {

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Fix the constructor

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: kAppThemeLight(),
      home: DummySplash(),
    );
  }
}

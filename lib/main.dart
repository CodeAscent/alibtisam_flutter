import 'package:alibtisam_flutter/features/commons/dummySplash/dummy_splash.dart';
import 'package:alibtisam_flutter/features/commons/home/presentation/settings/controller/theme_controller.dart';
import 'package:alibtisam_flutter/init/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Fix the constructor

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemeController(),
      builder: (controller) {
        return GetMaterialApp(
          theme: controller.appTheme(),
          home: DummySplash(),
        );
      },
    );
  }
}

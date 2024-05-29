import 'package:alibtisam_flutter/Localization/localization.dart';
import 'package:alibtisam_flutter/client/socket_io.dart';
import 'package:alibtisam_flutter/features/dummySplash/dummy_splash.dart';
import 'package:alibtisam_flutter/helper/theme/controller/theme_controller.dart';
import 'package:alibtisam_flutter/init/init_controllers.dart';
import 'package:alibtisam_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  SocketConnection.connectSocket();

  await GetStorage.init();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key); // Fix the constructor
  final savedLocale = GetStorage().read('locale') ?? 'en_US';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemeController(),
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: AppLocalization(),
          locale: Locale(savedLocale.split('_')[0], savedLocale.split('_')[1]),
          fallbackLocale: Locale('ar', 'DZ'),
          getPages: pages,
          theme: controller.appTheme(),
          home: DummySplash(),
        );
      },
    );
  }
}

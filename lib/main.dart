import 'package:SNP/Localization/localization.dart';
import 'package:SNP/client/socket_io.dart';
import 'package:SNP/features/dummySplash/dummy_splash.dart';
import 'package:SNP/firebase_options.dart';
import 'package:SNP/helper/theme/controller/theme_controller.dart';
import 'package:SNP/init/init_controllers.dart';
import 'package:SNP/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  SocketConnection.connectSocket();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  // FlutterNativeSplash.preserve(widgetsBindin g: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _fcmToken;

  final savedLocale = GetStorage().read('locale') ?? 'en_US';
  Future<void> _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    String? token = await messaging.getToken();
    setState(() {
      _fcmToken = token;
    });
    print("FCM TOKEN -------> $_fcmToken");
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

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

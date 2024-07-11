import 'package:alibtisam/Localization/localization.dart';
import 'package:alibtisam/client/socket_io.dart';
import 'package:alibtisam/core/error/no_internet.dart';
import 'package:alibtisam/core/localStorage/fcm_token.dart';
import 'package:alibtisam/core/localStorage/init_shared_pref.dart';
import 'package:alibtisam/features/dummySplash/dummy_splash.dart';
import 'package:alibtisam/firebase_options.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:alibtisam/init/init_controllers.dart';
import 'package:alibtisam/routes/app_routes.dart';
import 'package:connectivity_watcher/core/controller_service.dart';
import 'package:connectivity_watcher/screens/connection_watcher_wrapper.dart';
import 'package:connectivity_watcher/screens/custom_no_internet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  await SharedPref.initSharedPrefrences();
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
  String? installationId;
  final savedLocale = GetStorage().read('locale') ?? 'en_US';
  Future<void> _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    installationId =
        await FirebaseInstallations.id ?? 'Unknown installation id';
    String? token = await messaging.getToken();
    String? uid = await getUid();
    setState(() {
      _fcmToken = token;
    });
    await FcmToken().saveFcmToken(_fcmToken.toString());
    final authToken = await getToken();

    print("FCM TOKEN -------> $_fcmToken");
    print("INSTALLATION ID -------> $installationId");
    print("UID -------> $uid");
    print("TOKEN -------> $authToken");
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWatcherWrapper(
      offlineWidget: CustomNoInternetWrapper(
        builder: (p0) => NoInternetWidget(),
      ),
      connectivityStyle: NoConnectivityStyle.CUSTOM,
      builder: (context, connectionKey) => GetBuilder(
        init: ThemeController(),
        builder: (controller) {
          return GetMaterialApp(
            // navigatorKey: connectionKey, // add this key to material app
            debugShowCheckedModeBanner: false,
            translations: AppLocalization(),
            locale:
                Locale(savedLocale.split('_')[0], savedLocale.split('_')[1]),
            fallbackLocale: Locale('ar', 'DZ'),
            getPages: pages,
            theme: controller.appTheme(),
            home: DummySplash(),
          );
        },
      ),
    );
  }
}

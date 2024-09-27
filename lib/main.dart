import 'package:alibtisam/core/Localization/localization.dart';
import 'package:alibtisam/client/socket_io.dart';
import 'package:alibtisam/core/localStorage/fcm_token.dart';
import 'package:alibtisam/core/localStorage/init_shared_pref.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/dummySplash/dummy_splash.dart';
import 'package:alibtisam/firebase_options.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:alibtisam/init_controllers.dart';
import 'package:alibtisam/core/routes/app_routes.dart';
import 'package:alibtisam/service_locator.dart';
import 'package:devicelocale/devicelocale.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';

String? locale;

void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await initControllers();

  locale = await Devicelocale.defaultLocale;

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
  Future<void> initConditions() async {
    Logger().w("----------->" + locale!.substring(0, 2));
    setState(() {});
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().f(message.data);

      _showInAppNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _navigateToRoute(message.data['route']);
    });
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

  void _showInAppNotification(RemoteMessage message) {
    showSimpleNotification(
      Text(message.notification?.title ?? 'New Notification'),
      subtitle: Text(message.notification?.body ?? 'You have a new message'),
      background: primaryColor(),
      duration: Duration(seconds: 3),
    );
  }

  void _navigateToRoute(String? route) {
    if (route != null) {
      Get.toNamed(route);
    }
  }

  @override
  void initState() {
    super.initState();

    initConditions();
  }

  @override
  Widget build(BuildContext context) {
    return
        // ConnectivityWatcherWrapper(
        //   offlineWidget: CustomNoInternetWrapper(
        //     builder: (p0) => NoInternetWidget(),
        //   ),
        //   connectivityStyle: NoConnectivityStyle.CUSTOM,
        //   builder: (context, connectionKey) =>

        GetBuilder(
      init: ThemeController(),
      builder: (controller) {
        return OverlaySupport.global(
          child: GetMaterialApp(
            defaultTransition: Transition.cupertino,
            transitionDuration: Duration(milliseconds: 300),

            // navigatorKey: connectionKey, // add this key to material app
            debugShowCheckedModeBanner: false,
            translations: AppLocalization(),
            locale: locale!.substring(0, 2) == 'ar'
                ? Locale(locale!.substring(0, 2))
                : Locale(locale!.substring(0, 2)),

            //   Locale(savedLocale.split('_')[0], savedLocale.split('_')[1]),
            fallbackLocale: Locale('ar', 'DZ'),
            getPages: pages,
            theme: controller.appTheme(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
            home: DummySplash(),
          ),
        );
      },
    );
    // );
  }
}

import 'dart:io';

import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StoreNavigation extends StatefulWidget {
  const StoreNavigation({super.key});

  @override
  State<StoreNavigation> createState() => _StoreNavigationState();
}

class _StoreNavigationState extends State<StoreNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return StoreScreen();

    // userController.user!.role == "EXTERNAL USER"
    //     ? ExternalStore()
    //     : userController.user!.role == "INTERNAL USER"
    //         ? InternalStore()
    //         : CoachStore();
  }
}

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            Center(child: Text(progress.toString() + " %"));
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://ibti.org/'));
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          //   Get.back();
          return true;
        }
      },
      shouldAddCallback: true,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Get.back();
                }
              },
              icon: Icon(
                Icons.navigate_before,
                size: 40,
              )),
          title: Text('Alibtisam Store'.tr),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}

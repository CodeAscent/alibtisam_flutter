import 'dart:async';

import 'package:alibtisam/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam/features/signup&login/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam/features/signup&login/presentation/login/login.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  void initState() {
    super.initState();
    navigationFunction();
  }

  navigationFunction() async {
    await Future.delayed(Duration(seconds: 2));
    String? token = await getToken();

    token == null ? Get.to(() => LoginScreen()) : Get.to(() => BottomNav());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LogoAndArabicText(),
      ),
    );
  }
}

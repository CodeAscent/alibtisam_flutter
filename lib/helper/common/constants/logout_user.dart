import 'package:alibtisam_flutter/features/signup&login/presentation/login/login.dart';
import 'package:alibtisam_flutter/helper/localStorage/token.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> kLogoutUser(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Are You Sure You Want to Log Out?",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "no",
                  style: TextStyle(color: primaryColor()),
                )),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: primaryColor()),
                onPressed: () {
                  LoadingManager.dummyLoading();
                  remove('token');
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  "yes",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      });
}

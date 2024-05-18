import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackbar({required String message}) {
  if (!Get.isSnackbarOpen)
    Get.snackbar("Message", message,
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Row(
          children: [
            Text(
              "Message",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10));
}

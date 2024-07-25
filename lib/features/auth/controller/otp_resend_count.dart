import 'dart:async';

import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class OtpResendCountController extends GetxController {
  RxInt count = 60.obs;
  Timer? _timer;

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count.value > 0) {
        count.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    count.value = 60;
  }
}

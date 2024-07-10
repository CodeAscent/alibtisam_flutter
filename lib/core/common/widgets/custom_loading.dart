import 'package:alibtisam/core/common/controller/custom_loading_controller.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatefulWidget {
  final Widget child;
  const CustomLoader({super.key, required this.child});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  final loadingController = Get.find<CustomLoadingController>();

  @override
  void dispose() {
    loadingController.endLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomLoadingController>(
      initState: (state) {},
      init: loadingController,
      builder: (controller) {
        return BlurryModalProgressHUD(
          inAsyncCall: controller.loading,
          blurEffectIntensity: 4,
          progressIndicator: Lottie.asset(
            'assets/lottie/alibtisamloading.json',
            height: 200,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black,
          child: widget.child,
        );
      },
    );
  }
}

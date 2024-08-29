import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key,});

  @override
  Widget build(BuildContext context) {
    return  BlurryModalProgressHUD(
          inAsyncCall: true,
          blurEffectIntensity: 4,
          progressIndicator: Lottie.asset(
            'assets/lottie/alibtisamloading.json',
            height: 200,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black,
          child: Material(color: Colors.transparent,),
        );
    
    
  }
}

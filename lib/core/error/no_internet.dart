
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lottie/no_internet.json'),
          //   ElevatedButton(
          //       onPressed: () {
          //         Get.off(() => BottomNav());
          //       },
          //       child: Text('Try Again'),
          // ),
        ],
      ),
    ));
  }
}

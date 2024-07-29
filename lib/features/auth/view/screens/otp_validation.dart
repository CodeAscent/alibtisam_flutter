import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/auth/controller/otp_resend_count.dart';
import 'package:alibtisam/features/auth/repo/firebase_otp_validation.dart';
import 'package:alibtisam/features/auth/view/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam/features/auth/view/widgets/otp_pin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpValidation extends StatefulWidget {
  final String email;
  final String phone;
  final String name;
  final String password;

  const OtpValidation(
      {super.key,
      required this.email,
      required this.phone,
      required this.name,
      required this.password});

  @override
  State<OtpValidation> createState() => _OtpValidationState();
}

class _OtpValidationState extends State<OtpValidation> {
  final otpController = Get.find<OtpResendCountController>();
  @override
  void initState() {
    super.initState();
    // if (otpController.count.value == 0) {
    //   otpController.reset();
    //   customSnackbar(
    //       message: '6-digit OTP has been sent on your mobile number');
    // }
    // if (otpController.count.value == 60) {
    // }

    // otpController.start();
  }

  bool isLoading = false;
  @override
  void dispose() {
    // otpController.reset();
    super.dispose();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: LogoAndArabicText(),
              ),
              SizedBox(height: 60),
              OtpPinBox(
                controller: controller,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  //   Obx(
                  //     () => Visibility(
                  //         visible: otpController.count.value != 0,
                  //         child:
                  //             Text("00:" + otpController.count.value.toString())),
                  //   ),
                  TextButton(
                      onPressed: () {
                        FirebaseOtpValidation.verifyPhoneNumber(widget.phone);
                        // print(otpController.count.value);
                        // if (otpController.count.value == 0) {
                        //   otpController.reset();
                        //   otpController.start();

                        //   customSnackbar(
                        //       message:
                        //           '6-digit OTP has been sent on your mobile number');
                        // }
                      },
                      child: Text('Resend OTP'))
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 70,
                child: CustomGradientButton(
                    loading: isLoading,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseOtpValidation.validateOTP(
                          otp: controller.text,
                          email: widget.email,
                          password: widget.password,
                          mobile: widget.phone,
                          name: widget.name);
                      setState(() {
                        isLoading = false;
                      });
                      //   ApiRequests().register(
                      //       clubId: orgId,
                      //       email: emailController.text.trim(),
                      //       mobile: phoneController.text.trim(),
                      //       password: passwordController.text.trim(),
                      //       name: nameController.text.trim());
                    },
                    label: 'Validate OTP'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

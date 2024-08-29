import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/auth/view/screens/update_password.dart';
import 'package:alibtisam/features/auth/view/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam/features/auth/view/widgets/otp_pin.dart';
import 'package:alibtisam/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final otpController = TextEditingController();
  final phoneController = TextEditingController();
  bool showOtpBox = false;

  String selectedCountryCode = '+966';
  final authViewmodel = Get.find<AuthViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: LogoAndArabicText(),
              ),
              SizedBox(height: 50),
              CustomTextField(
                prefix: CountryCodePicker(
                  onChanged: (val) {
                    setState(() {
                      selectedCountryCode = val.dialCode!;
                    });
                  },

                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: '+966',
                  favorite: ['+91', 'IN', '+966'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
                maxLength: 10,
                controller: phoneController,
                label: "phone".tr,
              ),
              SizedBox(height: 20),
              Visibility(
                  visible: showOtpBox,
                  child: OtpPinBox(controller: otpController)),
              SizedBox(height: 10),
              if (showOtpBox)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          authViewmodel.sendOTP(
                              selectedCountryCode + phoneController.text);
                        },
                        child: Text('Resend OTP'))
                  ],
                ),
              SizedBox(height: 50),
              SizedBox(
                height: 70,
                child: CustomGradientButton(
                  label: showOtpBox ? 'Submit' : 'Continue',
                  onTap: showOtpBox == true
                      ? () {
                          if (otpController.text != '') {
                            authViewmodel.validateOTPForgotPassword(
                              otp: otpController.text,
                              mobile:
                                  selectedCountryCode + phoneController.text,
                            );
                          }
                        }
                      : () {
                          if (phoneController.text != '') {
                            setState(() {
                              showOtpBox = true;
                            });
                            authViewmodel.sendOTP(
                                selectedCountryCode + phoneController.text);
                          }
                        },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

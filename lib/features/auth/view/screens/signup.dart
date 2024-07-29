import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/auth/controller/otp_resend_count.dart';
import 'package:alibtisam/features/auth/view/screens/otp_validation.dart';
import 'package:alibtisam/features/auth/view/widgets/otp_pin.dart';
import 'package:alibtisam/features/auth/viewmodel/sign_up_viewmodel.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:alibtisam/network/org_id.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:alibtisam/features/auth/view/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
//   final clubController = TextEditingController();
//   final clubIdController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<dynamic> clubs = [];
  bool isSecurePassword = true;
  final otpController = Get.find<OtpResendCountController>();
  final signUpViewmodel = Get.find<SignUpViewmodel>();
  String selectedCountryCode = '+966';
  @override
  void initState() {
    super.initState();
    fetchClubs();
  }

  fetchClubs() async {
    final res = await ApiRequests().getClubs();
    for (var club in res) {
      clubs.add(club);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Form(
        key: formKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: LogoAndArabicText(),
                    ),
                    SizedBox(height: 10),
                    // CustomTextField(
                    //   controller: clubController,
                    //   maxLines: 1,
                    //   label: "sportsClub".tr,
                    //   height: 60,
                    //   readOnly: true,
                    //   suffix: DropdownButton(
                    //     items: clubs
                    //         .map((club) => DropdownMenuItem(
                    //             value: club, child: Text(club['name'])))
                    //         .toList(),
                    //     onChanged: (dynamic val) {
                    //       setState(() {
                    //         clubController.text = val['name'];
                    //         clubIdController.text = val['_id'];
                    //         Logger().w(val['_id']);
                    //       });
                    //     },
                    //     iconSize: 40,
                    //     isDense: true,
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    CustomTextField(
                      controller: nameController,
                      label: "name".tr,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: emailController,
                      label: "email".tr,
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    CustomTextField(
                      maxLines: 1,
                      suffix: TogglePassword(),
                      obscureText: isSecurePassword,
                      controller: passwordController,
                      label: "password".tr,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 70,
                      child: Obx(
                        () => CustomGradientButton(
                            loading: signUpViewmodel.loading.value,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                signUpViewmodel.checkUserExist(
                                    email: emailController.text,
                                    mobile: selectedCountryCode +
                                        phoneController.text,
                                    name: nameController.text,
                                    password: passwordController.text);
                              }
                            },
                            label: 'signUp'.tr),
                      ),
                    ),
                    SizedBox(height: 40),
                    Divider(),
                    SizedBox(height: 20),
                    Text("alreadyHaveAnAcoount".tr),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 70,
                      child: CustomGradientButton(
                          onTap: () {
                            Get.back();
                          },
                          label: 'login'.tr),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TogglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      icon: isSecurePassword
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
      color: primaryColor(),
    );
  }
}

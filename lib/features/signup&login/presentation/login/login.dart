import 'package:SNP/features/signup&login/presentation/signup/signup.dart';
import 'package:SNP/features/signup&login/widgets/logo_&_arabic_text.dart';
import 'package:SNP/core/common/widgets/custom_gradient_button.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/common/widgets/custom_text_field.dart';
import 'package:SNP/core/theme/app_colors.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSecurePassword = true;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      shouldAddCallback: true,
      child: CustomLoader(
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
                      SizedBox(height: 50),
                      CustomTextField(
                        controller: usernameController,
                        label: "userName&Email".tr,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        maxLines: 1,
                        obscureText: isSecurePassword,
                        suffix: TogglePassword(),
                        controller: passwordController,
                        label: "password".tr,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 70,
                        child: CustomGradientButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                ApiRequests().login(
                                    userName: usernameController.text.trim(),
                                    password: passwordController.text.trim());
                              }
                            },
                            label: 'login'.tr),
                      ),
                      SizedBox(height: 40),
                      Divider(),
                      SizedBox(height: 20),
                      Text("dontHaveAnAcoount".tr),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 70,
                        child: CustomGradientButton(
                            onTap: () {
                              Get.to(() => SignUpScreen());
                            },
                            label: 'signUp'.tr),
                      ),
                    ],
                  ),
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

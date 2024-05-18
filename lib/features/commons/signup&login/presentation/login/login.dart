import 'package:alibtisam_flutter/features/commons/home/custom_bottom_nav.dart';
import 'package:alibtisam_flutter/features/commons/signup&login/presentation/signup/signup.dart';
import 'package:alibtisam_flutter/features/commons/signup&login/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam_flutter/features/commons/home/presentation/externalDashboard/external_dashboard.dart';
import 'package:alibtisam_flutter/features/commons/home/presentation/userDashboard/user_dashboard.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
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
                        label: "Username",
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        label: "Password",
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ApiRequests().login(
                                  userName: usernameController.text.trim(),
                                  password: passwordController.text.trim());
                            }
                          },
                          child: Text('Login')),
                      SizedBox(height: 40),
                      Divider(),
                      SizedBox(height: 20),
                      Text("Don't have an acoount?"),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Text('Sign Up')),
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
}

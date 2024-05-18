import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:alibtisam_flutter/features/commons/signup&login/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: nameController,
                      label: "Name",
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: phoneController,
                      label: "Phone",
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
                            ApiRequests().register(
                                email: emailController.text.trim(),
                                mobile: phoneController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim());
                          }
                        },
                        child: Text('Sign Up')),
                    SizedBox(height: 40),
                    Divider(),
                    SizedBox(height: 20),
                    Text("Already have an acoount?"),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Login')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:SNP/helper/common/widgets/custom_gradient_button.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/theme/app_colors.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:SNP/features/signup&login/widgets/logo_&_arabic_text.dart';
import 'package:SNP/helper/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final clubController = TextEditingController();
  final clubIdController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<dynamic> clubs = [];
  bool isSecurePassword = true;

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
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: clubController,
                      maxLines: 1,
                      label: "sportsClub".tr,
                      height: 60,
                      readOnly: true,
                      suffix: DropdownButton(
                        items: clubs
                            .map((club) => DropdownMenuItem(
                                value: club, child: Text(club['name'])))
                            .toList(),
                        onChanged: (dynamic val) {
                          setState(() {
                            print(val);
                            clubController.text = val['name'];
                            clubIdController.text = val['_id'];
                          });
                        },
                        iconSize: 40,
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: nameController,
                      label: "name".tr,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      label: "email".tr,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      maxLength: 10,
                      controller: phoneController,
                      label: "phone".tr,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      maxLines: 1,
                      suffix: TogglePassword(),
                      obscureText: isSecurePassword,
                      controller: passwordController,
                      label: "password".tr,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 70,
                      child: CustomGradientButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              ApiRequests().register(
                                  clubId: clubIdController.text.trim(),
                                  email: emailController.text.trim(),
                                  mobile: phoneController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim());
                            }
                          },
                          label: 'signUp'.tr),
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

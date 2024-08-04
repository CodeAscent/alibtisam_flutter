import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/auth/repo/update_password_repo.dart';
import 'package:alibtisam/features/auth/view/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam/features/auth/view/widgets/otp_pin.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String username;
  const UpdatePasswordScreen({super.key, required this.username});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: LogoAndArabicText(),
                ),
                SizedBox(height: 50),
                CustomTextField(controller: newPassword, label: 'New Password'),
                SizedBox(height: 20),
                CustomTextField(
                  controller: confirmPassword,
                  label: 'Confirm New Password',
                  validator: (val) {
                    if (confirmPassword.text != newPassword.text) {
                      return "Passwords does not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                SizedBox(
                  height: 70,
                  child: CustomGradientButton(
                    label: 'Submit',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        UpdatePasswordRepo().updatePassword(
                            username: widget.username,
                            newPassword: newPassword.text);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

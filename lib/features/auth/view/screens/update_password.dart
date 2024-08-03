import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/auth/view/widgets/logo_&_arabic_text.dart';
import 'package:alibtisam/features/auth/view/widgets/otp_pin.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
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
              CustomTextField(label: 'New Password'),
              SizedBox(height: 20),
              CustomTextField(label: 'Confirm New Password'),
              SizedBox(height: 50),
              SizedBox(
                height: 70,
                child: CustomGradientButton(
                  label: 'Submit',
                  onTap: () {
                    setState(() {});
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

import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPinBox extends StatefulWidget {
    final TextEditingController controller;
  const OtpPinBox({super.key, required this.controller});

  @override
  State<OtpPinBox> createState() => _OtpPinBoxState();
}

class _OtpPinBoxState extends State<OtpPinBox> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor()),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primaryColor()),
      borderRadius: BorderRadius.circular(20),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: primaryColor(),
      ),
    );
    return Pinput(
        controller: widget.controller,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}

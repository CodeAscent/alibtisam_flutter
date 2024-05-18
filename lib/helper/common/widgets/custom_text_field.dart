import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.readOnly,
    this.initial,
    this.suffix,
  });

  final TextEditingController? controller;
  final String label;
  final bool? readOnly;
  final String? initial;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initial,
      readOnly: readOnly ?? false,
      validator: (value) => value == '' ? "Please enter your $label" : null,
      controller: controller,
      decoration: InputDecoration(labelText: label, suffix: suffix),
    );
  }
}

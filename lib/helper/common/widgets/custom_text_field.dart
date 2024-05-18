import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final double? width;
  final bool? readOnly;
  final double? height;
  final Widget? suffix;
  final bool? digitsOnly;
  final bool? shouldValidate;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? initial;
  const CustomTextField(
      {super.key,
      required this.label,
      this.width,
      this.controller,
      this.readOnly,
      this.suffix,
      this.height,
      this.onChanged,
      this.digitsOnly,
      this.keyboardType,
      this.maxLines,
      this.shouldValidate,
      this.maxLength,
      this.initial});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        initialValue: initial,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        controller: controller,
        maxLength: maxLength,
        validator: (val) {
          if (shouldValidate != false && controller!.text == '') {
            return "pleaseinputavalid $label".tr;
          }
          return null;
        },
        inputFormatters: digitsOnly ?? false
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
            : null,
        maxLines: maxLines,
        decoration: InputDecoration(
            counterText: "",
            suffixIcon: suffix,
            labelText: label,
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            errorMaxLines: 1,
            labelStyle: TextStyle(color: Colors.grey.shade700),
            errorStyle: TextStyle(color: Colors.red, height: 1),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}

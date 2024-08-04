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
  final String? hintText;
  final bool? obscureText;
  final Widget? prefix;
  final String? Function(String?)? validator;
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
      this.initial,
      this.obscureText,
      this.hintText,
      this.prefix, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: width,
      height: height,
      child: TextFormField(
        
        obscureText: obscureText ?? false,
        initialValue: initial,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        controller: controller,
        maxLength: maxLength,
        validator:validator != null ?validator: (val) {
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
            prefixIcon: prefix,
            hintText: hintText,
            counterText: "",
            suffixIcon: suffix,
            labelText: label,
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            errorMaxLines: 1,
            labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 11),
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

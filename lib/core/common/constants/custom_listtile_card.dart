import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container kCustomListTile(
    {required String key, required dynamic value, bool selected = false}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: selected ? kAppGreyColor() : null,
        border: Border.all(
          color: kAppGreyColor(),
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          value.toString().capitalize!,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}

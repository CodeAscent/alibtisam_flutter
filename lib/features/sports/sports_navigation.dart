import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/sports/views/screens/available_sports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportsNavigation extends StatefulWidget {
  const SportsNavigation({super.key});

  @override
  State<SportsNavigation> createState() => _SportsNavigationState();
}

class _SportsNavigationState extends State<SportsNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return AvailableSports();
  }
}

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> getSharedPrefTheme() async {
  final prefs = await SharedPreferences.getInstance();
  String theme = prefs.getString('theme') ?? 'light';
  return theme;
}

switchSharedPrefTheme(String val) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('theme', val);
}

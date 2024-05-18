import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

saveToken(String token) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString("token", token);
}

remove(String key) async {
  final pref = await SharedPreferences.getInstance();
  pref.remove(key);
}

Future<String?> getToken() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? null;
}

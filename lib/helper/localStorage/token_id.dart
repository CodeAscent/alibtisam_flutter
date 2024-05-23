import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

saveToken(String token, String id) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString("token", token);
  pref.setString("uid", id);
}
saveId( String id) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString("uid", id);
}

remove(String key) async {
  final pref = await SharedPreferences.getInstance();
  pref.remove(key);
}

Future<String?> getToken() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? null;
}

Future<String?> getUid() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('uid') ?? null;
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;
  static get getPref => prefs;
  static Future initSharedPrefrences() async {
    prefs = await SharedPreferences.getInstance();
  }
}

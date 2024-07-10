import 'package:alibtisam/core/localStorage/init_shared_pref.dart';

class FcmToken {
  final prefs = SharedPref.getPref;
  Future saveFcmToken(String value) async {
    await prefs.setString('fcm', value);
  }

  Future<String?> getFcmToken() async {
    return await prefs.getString('fcm');
  }
}

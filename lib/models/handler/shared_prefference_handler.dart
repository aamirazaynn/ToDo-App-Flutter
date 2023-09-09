import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  static Future<void> saveEmailToPreferences(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  static Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<void> deleteEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  static Future<bool> isUserLoggedIn() async {
  String? email = await SharedPreferencesHandler.getEmailFromPreferences();
  if (email != null && email.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
}

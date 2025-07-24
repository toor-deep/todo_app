import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginState({
  required bool isLoggedIn,
  required String headId,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
  await prefs.setString('headId', headId);
}

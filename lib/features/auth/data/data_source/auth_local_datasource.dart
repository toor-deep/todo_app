import 'package:hive/hive.dart';

import '../models/hive/user_local_model.dart';

class LocalAuthDataSource {
  final Box _authBox ;
  LocalAuthDataSource({required Box authBox}) : _authBox = authBox;

  Future<void> saveLoginState(bool isLoggedIn) async {
    await _authBox.put('isLoggedIn', isLoggedIn);
  }

  Future<void> saveUser(User user) async {
    await _authBox.put('user', user);
  }

  Future<bool> getLoginState() async {
    return _authBox.get('isLoggedIn', defaultValue: false);
  }

  Future<User?> getUser() async {
    return _authBox.get('user');
  }

  Future<void> logout() async {
    await _authBox.clear();
  }
}

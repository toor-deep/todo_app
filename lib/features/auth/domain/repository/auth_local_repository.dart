import 'package:todo/features/auth/domain/entity/auth_entity.dart';

abstract class AuthLocalRepository {
  Future<void> saveLoginState(bool isLoggedIn);
  Future<void> saveUser(AuthUser user);
  Future<bool> getLoginState();
  Future<AuthUser?> getUser();
  Future<void> logout();
}

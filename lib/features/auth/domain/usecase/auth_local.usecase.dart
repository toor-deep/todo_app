import 'package:todo/features/auth/domain/entity/auth_entity.dart';
import 'package:todo/features/auth/domain/repository/auth_local_repository.dart';

class LocalAuthUseCase {
  final AuthLocalRepository repository;

  LocalAuthUseCase(this.repository);

  Future<void> saveUser(AuthUser user) => repository.saveUser(user);

  Future<AuthUser?> getUser() => repository.getUser();

  Future<void> logout() => repository.logout();

  Future<bool> isLoggedIn() => repository.getLoginState();

  Future<void> saveLoginState(bool isLoggedIn) =>
      repository.saveLoginState(isLoggedIn);
}

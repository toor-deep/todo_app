import 'package:todo/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:todo/features/auth/data/models/hive/user_local_model.dart';
import 'package:todo/features/auth/domain/entity/auth_entity.dart';
import '../../domain/repository/auth_local_repository.dart';


class AuthLocalRepositoryImpl implements AuthLocalRepository {
  final LocalAuthDataSource localDataSource;

  AuthLocalRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveUser(AuthUser user) async {
    await localDataSource.saveUser(userFromEntity(user));
  }

  @override
  Future<AuthUser?> getUser() async {
    final localUser = localDataSource.getUser();
    return localUser.then((user) {
      if (user != null) {
        return user.toEntity();
      }
      return null;
    });
  }
  

  @override
  Future<bool> getLoginState() {
    return localDataSource.getLoginState();
  }

  @override
  Future<void> logout() {
    return localDataSource.logout();
  }

  @override
  Future<void> saveLoginState(bool isLoggedIn) {
    return localDataSource.saveLoginState(isLoggedIn);
  }
}

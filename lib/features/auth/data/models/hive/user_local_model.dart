import 'package:hive/hive.dart';
import 'package:todo/features/auth/domain/entity/auth_entity.dart';

part 'user_local_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });
}



extension UserModelMapper on User {
  AuthUser toEntity() {
    return AuthUser(
      uid: id,
      fullName: name,
      email: email,
      dateOfBirth: "",
    );
  }
}

User userFromEntity(AuthUser entity) {
  return User(
    id: entity.uid,
    name: entity.fullName,
    email: entity.email,
    token: '',
  );
}

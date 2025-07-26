
import '../../domain/entity/auth_entity.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.dateOfBirth,
  });

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      dateOfBirth: map['dateOfBirth'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
    };
  }
}

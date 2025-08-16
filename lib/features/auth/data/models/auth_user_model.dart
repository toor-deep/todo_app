
import '../../domain/entity/auth_entity.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.dateOfBirth,
     super.profilePicture,
  });

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      dateOfBirth: map['dateOfBirth'],
      profilePicture: map['profilePicture'] != null
          ? ProfilePicture(
              thumbnailUrl: map['profilePicture']['thumbnailUrl'],
              originalUrl: map['profilePicture']['originalUrl'],
            )
          : const ProfilePicture(thumbnailUrl: '', originalUrl: ''),
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'profilePicture': {
        'thumbnailUrl': profilePicture.thumbnailUrl,
        'originalUrl': profilePicture.originalUrl,
      },
    };
  }
}

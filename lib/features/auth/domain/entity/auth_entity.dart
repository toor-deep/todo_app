import 'package:equatable/equatable.dart';
import 'package:todo/features/auth/data/models/auth_user_model.dart';


class AuthUser extends Equatable {
  final String uid;
  final String email;
  final String fullName;
  final String dateOfBirth;
  final ProfilePicture profilePicture;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.dateOfBirth,
    this.profilePicture = const ProfilePicture(
      thumbnailUrl: '',
      originalUrl: '',
    ),
  });

  @override
  List<Object?> get props => [uid, email, fullName, dateOfBirth, profilePicture];

  AuthUser copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? dateOfBirth,
    ProfilePicture? profilePicture,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}

class ProfilePicture extends Equatable {
  final String? originalUrl;
  final String? thumbnailUrl;

  const ProfilePicture({
    required this.thumbnailUrl,
    this.originalUrl,
  });

  @override
  List<Object?> get props => [originalUrl, thumbnailUrl];

  ProfilePicture copyWith({
    String? originalUrl,
    String? thumbnailUrl,
  }) {
    return ProfilePicture(
      originalUrl: originalUrl ?? this.originalUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}

extension AuthUserModelExtension on AuthUser {
  AuthUserModel get authUserModel => AuthUserModel(
    uid: uid,
    email: email,
    fullName: fullName,
    dateOfBirth: dateOfBirth,
    profilePicture: profilePicture,
  );
}


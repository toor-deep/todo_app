import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  final String email;
  final String fullName;
  final String dateOfBirth;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.dateOfBirth,
  });
  @override
  List<Object?> get props => [uid, email, fullName, dateOfBirth];

}

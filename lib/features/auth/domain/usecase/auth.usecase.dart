import 'package:dartz/dartz.dart';

import 'package:todo/core/errors/failures.dart';

import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<Either<Failure, AuthUser>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String dateOfBirth,
  }) {
    return repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<Either<Failure, AuthUser>> signIn({
    required String email,
    required String password,
  }) {
    return repository.signIn(email: email, password: password);
  }

  Future<Either<Failure, void>> signOut() {
    return repository.signOut();
  }

  Future<Either<Failure, AuthUser>> getCurrentUser() {
    return repository.getCurrentUser();
  }

  Future<Either<Failure, AuthUser>> signInWithGoogle() {
    return repository.signInWithGoogle();
  }
}

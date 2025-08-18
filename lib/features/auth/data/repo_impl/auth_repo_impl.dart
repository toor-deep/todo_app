import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/auth/data/data_source/auth_data_source.dart';
import 'package:todo/features/auth/domain/entity/auth_entity.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthDataSource remoteDataSource;

  AuthRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<Either<Failure, AuthUser>> signIn({required String email, required String password}) {
   return remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<Either<Failure, void>> signOut() {
   return remoteDataSource.signOut();
  }

  @override
  Future<Either<Failure, AuthUser>> signUp({required String email, required String password, required String fullName, required String dateOfBirth}) {
  return remoteDataSource.signUp(email: email, password: password, fullName: fullName, dateOfBirth: dateOfBirth);
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithGoogle() {
   return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<Either<Failure, AuthUser>> updateProfile({required AuthUser user}) {
    return remoteDataSource.updateProfile(user: user.authUserModel);
  }


}
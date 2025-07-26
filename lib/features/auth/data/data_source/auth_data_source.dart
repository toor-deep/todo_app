import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/auth/data/models/auth_user_model.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/errors/auth_errors.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthUserModel>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthUserModel>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String dateOfBirth,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, AuthUserModel>> getCurrentUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, AuthUserModel>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String dateOfBirth,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return left(ServerFailure(message: 'User creation failed'));
      }

      final authUser = AuthUserModel(
        uid: user.uid,
        email: email,
        fullName: fullName,
        dateOfBirth: dateOfBirth,
      );

      await ApiUrl.users.doc(user.uid).set(authUser.toMap());

      return right(authUser);
    } on FirebaseAuthException catch (e) {
      final message = getMessageFromErrorCode(e.code);

      return left(ServerFailure(message: message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return left(ServerFailure(message: 'User not found'));
      }

      final doc = await ApiUrl.users.doc(user.uid).get();

      if (!doc.exists || doc.data() == null) {
        return left(ServerFailure(message: 'User data not found in Firestore'));
      }

      final authUser = AuthUserModel.fromMap(doc.data()!);

      return right(authUser);
    } on FirebaseAuthException catch (e) {
      final message = getMessageFromErrorCode(e.code);

      return left(ServerFailure(message: message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _auth.signOut();
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: 'Sign out failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left(ServerFailure(message: 'No user is currently signed in.'));
      }

      final doc = await ApiUrl.users.doc(user.uid).get();
      if (!doc.exists || doc.data() == null) {
        return left(ServerFailure(message: 'User data not found in Firestore'));
      }

      final authUser = AuthUserModel.fromMap(doc.data()!);
      return right(authUser);
    } catch (e) {
      return left(ServerFailure(message: 'Failed to fetch current user: ${e.toString()}'));
    }
  }
}

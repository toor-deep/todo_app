import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/features/auth/data/models/auth_user_model.dart';
import 'package:todo/features/auth/domain/entity/auth_entity.dart';
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

  Future<Either<Failure, AuthUserModel>> signInWithGoogle();

  Future<Either<Failure, AuthUserModel>> updateProfile({
    required AuthUserModel user,
  });
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
        profilePicture: ProfilePicture(thumbnailUrl: '', originalUrl: ''),
      );

      await ApiUrl.users.doc(user.uid).set(authUser.toMap());

      return right(authUser);
    } on FirebaseAuthException catch (e) {
      print(e);
      final message = getMessageFromErrorCode(e.code);

      return left(ServerFailure(message: message));
    } catch (e) {
      print(e);
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
      return left(
        ServerFailure(message: 'Failed to fetch current user: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return left(ServerFailure(message: 'User cancelled Google Sign-In'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        return left(
          ServerFailure(message: 'Firebase user is null after sign-in'),
        );
      }

      final AuthUserModel authUser = AuthUserModel(
        uid: user.uid,
        email: user.email ?? '',
        fullName: user.displayName ?? '',
        dateOfBirth: '',
      );

      return right(authUser);
    } catch (e) {
      return left(
        ServerFailure(message: 'Google Sign-In Error: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> updateProfile({
    required AuthUserModel user,
  }) async {
    try {
      final userDoc = ApiUrl.users.doc(user.uid);

      final Map<String, dynamic> userData = user.toMap()
        ..removeWhere((key, value) => value == null || value == "");

      if (userData.isEmpty) {
        return left(ServerFailure(message: "No fields to update"));
      }

      await userDoc.update(userData);

      return right(user);
    } catch (e) {
      return left(
        ServerFailure(message: 'Failed to update profile: ${e.toString()}'),
      );
    }
  }

}

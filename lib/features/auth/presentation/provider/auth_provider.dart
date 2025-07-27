import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/features/auth/domain/usecase/auth.usecase.dart';
import 'package:todo/features/auth/domain/usecase/auth_local.usecase.dart';
import 'package:todo/shared/toast_alert.dart';

import '../../data/models/hive/user_local_model.dart';
import '../../domain/entity/auth_entity.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthUseCase authUseCase;
  final LocalAuthUseCase localAuthUseCase;

  AuthenticationProvider({
    required this.authUseCase,
    required this.localAuthUseCase,
  }) {
    init();
  }

  Future<void> init() async {
    currentUser = await getCurrentUser();
    notifyListeners();
  }

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  AuthUser? currentUser;

  Future<void> signUp(
    String email,
    String password,
    String dateOfBirth,
    String name,
    String phoneNumber,
    Function onSuccess,
  ) async {
    try {
      _setLoading(true);
      final response = await authUseCase.signUp(
        email: email,
        password: password,
        fullName: name,
        dateOfBirth: dateOfBirth,
      );
      response.fold(
        (l) {
          showSnackbar(l.message, color: Colors.red);
          _setLoading(false);
        },
        (r) async {
          _setLoading(false);
          _setError(null);
          await localAuthUseCase.saveLoginState(true);
          onSuccess();
          showSnackbar("Registration successful!", color: Colors.green);
        },
      );
    } catch (e) {
      showSnackbar(e.toString(), color: Colors.red);
      _setLoading(false);
    }
  }

  Future<void> signIn(String email, String password, Function onSuccess) async {
    try {
      _setLoading(true);
      final response = await authUseCase.signIn(
        email: email,
        password: password,
      );
      response.fold(
        (l) {
          showSnackbar(l.message, color: Colors.red);
          _setLoading(false);
        },
        (r) async {
          _setLoading(false);
          _setError(null);
          await localAuthUseCase.saveLoginState(true);
          onSuccess();
          showSnackbar("Login successful!", color: Colors.green);
        },
      );
    } catch (e) {
      showSnackbar(e.toString(), color: Colors.red);
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle(Function onSuccess) async {
    try {
      final response = await authUseCase.signInWithGoogle();
      response.fold(
        (l) {
          print(l.message);

          showSnackbar(l.message, color: Colors.red);
          _setLoading(false);
        },
        (r) async {
          _setLoading(false);
          _setError(null);
          await localAuthUseCase.saveLoginState(true);
          onSuccess();
          showSnackbar("Login successful!", color: Colors.green);
        },
      );
    } catch (e) {
      print(e);
      showSnackbar(e.toString(), color: Colors.red);
      _setLoading(false);
    }
  }

  Future<void> signOut(Function onSuccess) async {
    await authUseCase.signOut();
    onSuccess();
    await localAuthUseCase.logout();

    showSnackbar("Logged out successfully!", color: Colors.green);
    notifyListeners();
  }

  Future<AuthUser?> getCurrentUser({Function? onSuccess}) async {
    final result = await authUseCase.getCurrentUser();

    return result.fold(
      (failure) {
        debugPrint("Failed to get user: ${failure.message}");
        return null;
      },
      (authUser) {
        currentUser = authUser;
        if (onSuccess != null) {
          onSuccess();
        }
        return authUser;
      },
    );
  }

  Future<void> saveUserLocally(AuthUser user) async {
    final userBox = Hive.box<User>('userBox');
    final localUser = userFromEntity(user);
    await userBox.put('currentUser', localUser);
  }

  AuthUser? getLocalUser() {
    final userBox = Hive.box<User>('userBox');
    final localUser = userBox.get('currentUser');
    return localUser?.toEntity();
  }

  Future<void> clearLocalUser() async {
    final userBox = Hive.box<User>('userBox');
    await userBox.delete('currentUser');
  }

  Future<bool> isUserLoggedIn() async {
    return await localAuthUseCase.isLoggedIn();
  }
}

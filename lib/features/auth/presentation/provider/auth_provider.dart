import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/auth/domain/usecase/auth.usecase.dart';
import 'package:todo/shared/toast_alert.dart';

import '../../../../core/database/shared_preferences.dart';
import '../../domain/entity/auth_entity.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthUseCase authUseCase;

  AuthenticationProvider({required this.authUseCase}){
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
        (r) {
          _setLoading(false);
          _setError(null);
          saveLoginState(isLoggedIn: true);
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
          await saveLoginState(isLoggedIn: true);
          onSuccess();
          showSnackbar("Login successful!", color: Colors.green);
        },
      );
    } catch (e) {
      showSnackbar(e.toString(), color: Colors.red);
      _setLoading(false);
    }
  }

  Future<void> signOut(Function onSuccess) async {
    await authUseCase.signOut();
    onSuccess();
    await clearLoginState();

    showSnackbar("Logged out successfully!",color: Colors.green);
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
        if(onSuccess!=null){
        onSuccess();}
        return authUser;
      },
    );
  }


}

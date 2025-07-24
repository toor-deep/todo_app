import 'package:flutter/material.dart';
import '../theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateUserRole(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}

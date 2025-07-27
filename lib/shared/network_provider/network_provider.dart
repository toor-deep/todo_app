import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isConnected = true;
  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    _initializeConnectivity();
  }

  void _initializeConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);

    _subscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _isConnected = results.any((r) =>
    r == ConnectivityResult.wifi || r == ConnectivityResult.mobile);
    notifyListeners();
  }


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../features/todo_home_page/services/sync_manager.dart';

class ConnectivityProvider extends ChangeNotifier {
  final SyncManager syncManager;

  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isConnected = true;
  bool get isConnected => _isConnected;

  ConnectivityProvider({required this.syncManager}) {
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
    syncManager.syncPendingTasksIfOnline(isConnected);

    notifyListeners();
  }


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

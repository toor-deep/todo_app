import 'package:flutter/cupertino.dart';
import '../domain/usecase/task.usecase.dart';
import '../domain/usecase/task_local.usecase.dart';
import 'package:todo/features/auth/presentation/provider/auth_provider.dart';

class SyncManager {
  final TaskLocalUseCase taskLocalUseCase;
  final TaskUseCase taskUseCase;
  final AuthenticationProvider authProvider;

  bool _isSyncing = false;

  SyncManager({
    required this.taskLocalUseCase,
    required this.taskUseCase,
    required this.authProvider,
  });

  Future<void> syncPendingTasksIfOnline(bool isConnected) async {
    if (!isConnected || _isSyncing) return;
    _isSyncing = true;

    try {
      final userId = authProvider.currentUser?.uid;
      if (userId == null) return;

      final pendingTasks = await taskLocalUseCase.getUnsyncedTasks();

      for (var task in pendingTasks) {
        if (task.syncAction != 'create' &&
            task.syncAction != 'update' &&
            task.syncAction != 'delete') {
          continue;
        }

        final syncingTask = task.copyWith(syncAction: 'syncing');
        await taskLocalUseCase.updateTask(syncingTask);

        try {
          switch (task.syncAction) {
            case 'create':
              await taskUseCase.addTask(syncingTask, userId);
              break;
            case 'update':
              await taskUseCase.updateTask(syncingTask, userId);
              break;
            case 'delete':
              await taskUseCase.deleteTask(syncingTask.id ?? "", userId);
              break;
          }

          final syncedTask = syncingTask.copyWith(
            isSynced: true,
            syncAction: 'none',
          );
          await taskLocalUseCase.updateTask(syncedTask);
        } catch (e) {
          debugPrint('Sync failed for task ${task.id}: $e');
          await taskLocalUseCase.updateTask(task);
        }
      }
    } finally {
      _isSyncing = false;
    }
  }
}

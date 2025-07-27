import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';

import '../../domain/repository/task_local_repository.dart';
import '../data_source/task_local_data_source.dart';
import '../models/hive_model/task_local_model.dart';


class TaskLocalRepositoryImpl implements TaskLocalRepository {
  final TaskLocalDataSource dataSource;

  TaskLocalRepositoryImpl(this.dataSource);

  @override
  Future<void> addTask(TaskEntity task) => dataSource.addTask(TaskLocalModel.fromEntity(task));

  @override
  List<TaskEntity> getAllTasks() => dataSource.getAllTasks()
      .map((taskModel) => taskModel.toEntity())
      .toList();

  @override
  Future<void> deleteTask(String id) => dataSource.deleteTask(id);

  @override
  Future<void> clearAllTasks() {
    return dataSource.clearAllTasks();
  }

  @override
  Future<List<TaskEntity>> getUnsyncedTasks() async {
    final localModels = dataSource.getUnsyncedTasks();
    return localModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    return dataSource.updateTask(TaskLocalModel.fromEntity(task));
  }
}

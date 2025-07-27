import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';

import '../repository/task_local_repository.dart';

class TaskLocalUseCase {
  final TaskLocalRepository repository;

  TaskLocalUseCase(this.repository);

  Future<void> addTask(TaskEntity task) => repository.addTask(task);

  List<TaskEntity> getAllTasks() => repository.getAllTasks();

  Future<void> deleteTask(String id) => repository.deleteTask(id);

  Future<void> clearAllTasks() async {
    await repository.clearAllTasks();
  }

  Future<List<TaskEntity>> getUnsyncedTasks() async {
    return await repository.getUnsyncedTasks();
  }

  Future<void> updateTask(TaskEntity task) {
    return repository.updateTask(task);
  }
}

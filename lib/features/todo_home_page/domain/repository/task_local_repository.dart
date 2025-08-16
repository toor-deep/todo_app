import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';

abstract class TaskLocalRepository {
  Future<void> addTask(TaskEntity task);
  List<TaskEntity> getAllTasks();
  Future<void> deleteTask(String id);
  Future<void> clearAllTasks();
  Future<List<TaskEntity>> getUnsyncedTasks();
  Future<void> updateTask(TaskEntity task);
  List<TaskEntity> getTasksByDate(String date);

}
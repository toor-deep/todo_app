import 'package:hive/hive.dart';
import 'package:todo/features/todo_home_page/data/models/hive_model/task_local_model.dart';

class TaskLocalDataSource {
  final Box _taskBox;

  TaskLocalDataSource({required Box taskBox}) : _taskBox = taskBox;

  Future<void> addTask(TaskLocalModel task) async {
    await _taskBox.put(task.id, task);
  }

  List<TaskLocalModel> getAllTasks() {
    return _taskBox.values.cast<TaskLocalModel>().toList();
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }

  Future<void> clearAllTasks() async {
    await _taskBox.clear();
  }
  List<TaskLocalModel> getUnsyncedTasks() {
    return _taskBox.values
        .cast<TaskLocalModel>()
        .where((task) => task.isSynced == false)
        .toList();
  }
  Future<void> updateTask(TaskLocalModel task) async {
    await _taskBox.put(task.id, task);
  }

  List<TaskLocalModel> getTasksByDate(String date) {
    String dueDate=DateTime.parse(date).toUtc().toIso8601String().split('T').first;

    return _taskBox.values
        .where((task) => task.dueDate == dueDate)
        .cast<TaskLocalModel>()
        .toList();
  }


}

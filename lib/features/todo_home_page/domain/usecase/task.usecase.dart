import 'package:dartz/dartz.dart';
import 'package:todo/features/todo_home_page/domain/repository/task_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entity/task_entity.dart';

class TaskUseCase {
  final TaskRepository taskRepository;

  TaskUseCase({required this.taskRepository});

  Future<Either<Failure, void>> deleteTask( String taskId,String userId) {
    return taskRepository.deleteTask( taskId,userId);
  }

  Future<Either<Failure, List<TaskEntity>>> getAllTasks(String userId) {
    return taskRepository.getAllTasks(userId);
  }

  Future<Either<Failure, TaskEntity>> getTask(String userId, String taskId) {
    return taskRepository.getTask(userId, taskId);
  }

  Future<Either<Failure, TaskEntity>> addTask(TaskEntity taskModel,String userId) {
    return taskRepository.addTask(taskModel,userId);
  }

  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity taskModel,String userId) {
    return taskRepository.updateTask(taskModel,userId);
  }
  Future<Either<Failure, List<TaskEntity>>> getTasksByDate(String date,String userId) {
    return taskRepository.getTasksByDate(date,userId);
  }

}

import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo_home_page/data/data_source/task_data_source.dart';
import 'package:todo/features/todo_home_page/data/models/task_model.dart';
import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';
import 'package:todo/features/todo_home_page/domain/repository/task_repository.dart';

class TaskRepoImpl extends TaskRepository{
  final TaskDataSource taskDataSource;
  TaskRepoImpl({
    required this.taskDataSource,
  });
  @override
  Future<Either<Failure, TaskEntity>> addTask(TaskEntity taskModel,String userId) {
   return taskDataSource.addTask(TaskModel.fromEntity(taskModel),userId).then((value) {
      return value.fold(
        (left) => Left(left),
        (right) => Right(right.toTaskEntity),
      );
    });
  }

  @override
  Future<Either<Failure, void>> deleteTask( String taskId,String userId) {
    return taskDataSource.deleteTask( taskId,userId).then((value) {
      return value.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    });
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(String userId) {
    return taskDataSource.getAllTasks(userId).then((value) {
      return value.fold(
        (left) => Left(left),
        (right) => Right(right.map((task) => task.toTaskEntity).toList()),
      );
    });
  }

  @override
  Future<Either<Failure, TaskEntity>> getTask(String userId, String taskId) {
    return taskDataSource.getTask( taskId,userId).then((value) {
      return value.fold(
        (left) => Left(left),
        (right) => Right(right.toTaskEntity),
      );
    });
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity taskModel,String userId) {
    return taskDataSource.updateTask(TaskModel.fromEntity(taskModel),userId).then((value) {
      return value.fold(
        (left) => Left(left),
        (right) => Right(right.toTaskEntity),
      );
    });
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksByDate(String date,String userId) {
    return taskDataSource.getTasksByDate(date,userId).then((value) {
      return value.fold(
            (left) => Left(left),
            (right) => Right(right.map((task) => task.toTaskEntity).toList()),
      );
    });
  }

}
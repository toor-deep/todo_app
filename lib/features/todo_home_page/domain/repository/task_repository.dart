import 'package:dartz/dartz.dart';
import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class TaskRepository{

  Future<Either<Failure, TaskEntity>> addTask(TaskEntity taskModel,String userId);
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity taskModel,String userId);
  Future<Either<Failure, void>> deleteTask( String taskId,String userId);
  Future<Either<Failure, TaskEntity>> getTask(String userId, String taskId);
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(String userId);
  Future<Either<Failure, List<TaskEntity>>> getTasksByDate(String date,String userId);

}
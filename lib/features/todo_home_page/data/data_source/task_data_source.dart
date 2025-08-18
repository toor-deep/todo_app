import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/todo_home_page/data/models/task_model.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/errors/failures.dart';

abstract class TaskDataSource {
  Future<Either<Failure, TaskModel>> addTask(TaskModel taskModel,String userId);
  Future<Either<Failure, TaskModel>> updateTask(TaskModel taskModel,String userId);
  Future<Either<Failure, void>> deleteTask( String taskId,String userId);
  Future<Either<Failure, TaskModel>> getTask( String taskId,String userId);
  Future<Either<Failure, List<TaskModel>>> getAllTasks(String userId);
  Future<Either<Failure, List<TaskModel>>> getTasksByDate(String date,String userId);
}

class TaskDataSourceImpl implements TaskDataSource {

  TaskDataSourceImpl();


  @override
  Future<Either<Failure, TaskModel>> addTask(TaskModel taskModel,String userId) async {
    try {
      final docRef = ApiUrl.userTasks(userId).doc();
      final newTask = taskModel.copyWith(id: docRef.id);
      await docRef.set(newTask.toMap());
      return Right(newTask);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }


  @override
  Future<Either<Failure, TaskModel>> updateTask(TaskModel taskModel,String userId) async {
    try {
      await ApiUrl.singleTask(userId, taskModel.id).update(taskModel.toMap());
      return Right(taskModel);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask( String taskId,String userId) async {
    try {
      await ApiUrl.singleTask(userId, taskId).delete();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> getTask(String taskId,String userId) async {
    try {
      final doc = await ApiUrl.singleTask(userId, taskId).get();
      if (doc.exists) {
        return Right(TaskModel.fromMap(doc.data()!).copyWith(id: doc.id));
      } else {
        return Left(GenericFailure(message: "Task not found"));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks(String userId) async {
    try {
      final snapshot = await ApiUrl.userTasks(userId).get();
      final tasks = snapshot.docs.map((doc) => TaskModel.fromMap(doc.data()).copyWith(id: doc.id)).toList();
   for(var e in snapshot.docs){
     print(e.data());
   }
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getTasksByDate(String date,String userId) async {
    try {
      String dueDate=DateTime.parse(date).toUtc().toIso8601String().split('T').first;

      final snapshot = await ApiUrl.userTasks(userId)
          .where('dueDate', isEqualTo: dueDate)
          .get();


      final tasks = snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data()).copyWith(id: doc.id))
          .toList();

      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

}

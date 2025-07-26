import 'package:equatable/equatable.dart';
import 'package:todo/features/todo_home_page/data/models/task_model.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String title;
  final String taskPriority;
  final String dueDate;
  final String description;
  final String dueTime;
  final bool isCompleted;

  const TaskEntity({
     this.id,
    required this.title,
    required this.taskPriority,
    required this.dueDate,
    required this.description,
    required this.dueTime,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    taskPriority,
    dueDate,
    description,
    dueTime,
    isCompleted,
  ];
  TaskEntity copyWith({
    String? id,
    String? title,
    String? taskPriority,
    String? dueDate,
    String? description,
    String? dueTime,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      taskPriority: taskPriority ?? this.taskPriority,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

}

extension TaskEntityExtension on TaskModel{
  TaskEntity get toTaskEntity => TaskEntity(
    id: id,
    title: title,
    taskPriority: taskPriority,
    dueDate: dueDate,
    description: description,
    dueTime: dueTime,
    isCompleted: isCompleted,
  );
}

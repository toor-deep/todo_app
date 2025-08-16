import '../../domain/entity/task_entity.dart';

class TaskModel {
  final String id;
  final String title;
  final String taskPriority;
  final String dueDate;
  final String description;
  final String dueTime;
  final bool isCompleted;
  final bool isSynced;
  final String? syncAction;

  const TaskModel({
    required this.id,
    required this.title,
    required this.taskPriority,
    required this.dueDate,
    required this.description,
    required this.dueTime,
    this.isCompleted = false,
    this.isSynced = true,
    this.syncAction,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      taskPriority: map['taskPriority'] ?? '',
      dueDate: map['dueDate'] ?? '',
      description: map['description'] ?? '',
      dueTime: map['createdAt'],
      isCompleted: map['isCompleted'] ?? false,
      isSynced: map['isSynced'] ?? false,
      syncAction: map['syncAction'] ?? 'none',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'taskPriority': taskPriority,
      'dueDate': dueDate,
      'description': description,
      'createdAt': dueTime,
      'isCompleted': isCompleted,
      'isSynced': isSynced,
      'syncAction': syncAction ?? 'none',
    };
  }

  /// Convert Model to Entity
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      taskPriority: taskPriority,
      dueDate: dueDate,
      description: description,
      dueTime: dueTime,
      isCompleted: isCompleted,
      isSynced: isSynced,
      syncAction: syncAction,
    );
  }

  /// Convert Entity to Model
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id??"",
      title: entity.title,
      taskPriority: entity.taskPriority,
      dueDate: entity.dueDate,
      description: entity.description,
      dueTime: entity.dueTime,
      isCompleted: entity.isCompleted,
      isSynced: entity.isSynced??false,
      syncAction: entity.syncAction,
    );
  }
  TaskModel copyWith({
    String? id,
    String? title,
    String? taskPriority,
    String? dueDate,
    String? description,
    String? dueTime,
    bool? isCompleted,
    bool? isSynced,
    String? syncAction,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      taskPriority: taskPriority ?? this.taskPriority,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
      isSynced: isSynced ?? this.isSynced,
      syncAction: syncAction ?? this.syncAction,
    );
  }
}

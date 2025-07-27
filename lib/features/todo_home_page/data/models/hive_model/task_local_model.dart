import 'package:hive/hive.dart';

import '../../../domain/entity/task_entity.dart';

part 'task_local_model.g.dart';

@HiveType(typeId: 2)
class TaskLocalModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String taskPriority;

  @HiveField(3)
  final String dueDate;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String dueTime;

  @HiveField(6)
  final bool isCompleted;

  @HiveField(7)
  final bool isSynced;

  @HiveField(8)
  final String syncAction;

   TaskLocalModel({
    required this.id,
    required this.title,
    required this.taskPriority,
    required this.dueDate,
    required this.description,
    required this.dueTime,
    this.syncAction = 'none',
    this.isCompleted = false,
    this.isSynced = false,
  });

  factory TaskLocalModel.fromMap(Map<String, dynamic> map) {
    return TaskLocalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      taskPriority: map['taskPriority'] ?? '',
      dueDate: map['dueDate'] ?? '',
      description: map['description'] ?? '',
      dueTime: map['createdAt'],
      isCompleted: map['isCompleted'] ?? false,
      isSynced: map['isSynced'] ?? true,
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
      'syncAction': syncAction,
    };
  }

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

  factory TaskLocalModel.fromEntity(TaskEntity entity) {
    return TaskLocalModel(
      id: entity.id ?? "",
      title: entity.title,
      taskPriority: entity.taskPriority,
      dueDate: entity.dueDate,
      description: entity.description,
      dueTime: entity.dueTime,
      isCompleted: entity.isCompleted,
      isSynced: entity.isSynced??true,
      syncAction: entity.syncAction??'none'
    );
  }

  TaskLocalModel copyWith({
    String? id,
    String? title,
    String? taskPriority,
    String? dueDate,
    String? description,
    String? dueTime,
    bool? isCompleted,
    bool? isSynced,
  }) {
    return TaskLocalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      taskPriority: taskPriority ?? this.taskPriority,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}

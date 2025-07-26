import 'package:hive/hive.dart';

import '../../../domain/enityt/notification_entity.dart';

part 'notification_model.g.dart'; // Generated file

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  bool isReminder;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
    required this.isReminder,
  });
  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      dateTime: entity.dateTime,
      isReminder: entity.isReminder,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      dateTime: dateTime,
      isReminder: isReminder,
    );
  }
}

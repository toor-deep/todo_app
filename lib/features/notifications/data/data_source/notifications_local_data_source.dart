import 'package:hive/hive.dart';
import '../../domain/enityt/notification_entity.dart';
import '../model/notifications_local_model/notification_model.dart';

class LocalNotificationDataSource {
  final Box<NotificationModel> box;

  LocalNotificationDataSource(this.box);

  Future<void> addNotification(NotificationEntity entity) async {
    final model = NotificationModel.fromEntity(entity);
    await box.put(model.id, model);
  }

  List<NotificationEntity> getAllNotifications() {
    print(box.values.length);
    return box.values.map((e) => e.toEntity()).toList();
  }

  Future<void> deleteNotification(String id) async {
    await box.delete(id);
  }

  Future<void> clearAll() async {
    await box.clear();
  }
}

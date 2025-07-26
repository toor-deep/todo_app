import '../enityt/notification_entity.dart';

abstract class NotificationRepository {
  Future<void> addNotification(NotificationEntity notification);
  List<NotificationEntity> getAllNotifications();
  Future<void> deleteNotification(String id);
  Future<void> clearAllNotifications();
}

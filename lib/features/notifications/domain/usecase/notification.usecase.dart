
import '../enityt/notification_entity.dart';
import '../respository/notifcation_repo.dart';

class NotificationUseCase {
  final NotificationRepository repository;

  NotificationUseCase(this.repository);

  Future<void> addNotification(NotificationEntity notification) {
    return repository.addNotification(notification);
  }
  List<NotificationEntity> getNotification() {
    return repository.getAllNotifications();
  }
  Future<void> deleteNotification(String id) {
    return repository.deleteNotification(id);
  }
}

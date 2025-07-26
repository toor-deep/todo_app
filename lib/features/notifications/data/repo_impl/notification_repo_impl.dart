import 'package:hive/hive.dart';
import 'package:todo/features/notifications/data/data_source/notifications_local_data_source.dart';

import '../../domain/enityt/notification_entity.dart';
import '../../domain/respository/notifcation_repo.dart';
import '../model/notifications_local_model/notification_model.dart';


class NotificationRepositoryImpl implements NotificationRepository {
  final LocalNotificationDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addNotification(NotificationEntity notification) async {
    // final model = NotificationModel.fromEntity(notification);
    await remoteDataSource.addNotification(notification);
  }

  @override
  List<NotificationEntity> getAllNotifications() {
    return remoteDataSource.getAllNotifications();
  }

  @override
  Future<void> deleteNotification(String id) async {
    await remoteDataSource.deleteNotification(id);
  }

  @override
  Future<void> clearAllNotifications() async {
    await remoteDataSource.clearAll();
  }
}

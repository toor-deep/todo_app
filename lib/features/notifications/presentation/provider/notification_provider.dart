import 'package:flutter/cupertino.dart';
import '../../domain/enityt/notification_entity.dart';
import '../../domain/usecase/notification.usecase.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationUseCase notificationUseCase;

  NotificationProvider({required this.notificationUseCase});

  List<NotificationEntity> _notifications = [];
  bool _isLoading = false;

  List<NotificationEntity> get notifications => _notifications;

  bool get isLoading => _isLoading;

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    _notifications = notificationUseCase.getNotification();
    print(_notifications.length);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNotification(NotificationEntity notification) async {
    _isLoading = true;
    notifyListeners();

    await notificationUseCase.addNotification(notification);
    _notifications.add(notification);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteNotification(String id) async {
    _isLoading = true;
    notifyListeners();

    await notificationUseCase.deleteNotification(id);
    _notifications.removeWhere((n) => n.id == id);

    _isLoading = false;
    notifyListeners();
  }
}

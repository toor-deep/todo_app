import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'core.dart';
import 'data/model/notifications_local_model/notification_model.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotif.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        print("Notification tapped with payload: ${response.payload}");
      },
    );

    await _fcm.requestPermission();

    String? apnsToken = await _fcm.getAPNSToken();
    print('APNs Token: $apnsToken');

    final token = await _fcm.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received in foreground: ${message.notification?.title}');
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened via notification: ${message.notification?.title}');
    });
  }

  static Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = notification?.android;

    if (notification == null || android == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel_id',
          'Default Channel',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotif.show(
      message.hashCode,
      notification.title ?? 'No Title',
      notification.body ?? 'No Body',
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notifDetails = NotificationDetails(android: androidDetails);

    await _localNotif.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notifDetails,
    );
    final notificationBox = Hive.box<NotificationModel>('notificationsBox');

    final newNotification = NotificationModel(
      id: DateTime.now().toIso8601String(),
      title: title,
      body: body,
      dateTime: DateTime.now().add(Duration(minutes: 1)),
      isReminder: true,
    );

    await notificationBox.put(newNotification.id, newNotification);
  }

  static Future<void> scheduleReminder({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    print('Scheduled time (raw): $scheduledTime');

    final tzScheduled = tz.TZDateTime(
      tz.local,
      scheduledTime.year,
      scheduledTime.month,
      scheduledTime.day,
      scheduledTime.hour,
      scheduledTime.minute,
      scheduledTime.second,
    );
    print('Scheduled time (TZ): $tzScheduled');

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminder Notifications',
      channelDescription: 'This channel is used for scheduled reminders.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const notifDetails = NotificationDetails(android: androidDetails);

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotif.zonedSchedule(
      notificationId,
      title,
      body,
      tzScheduled.toLocal(),
      notifDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    print('Notification scheduled with ID $notificationId at $tzScheduled');
  }
}

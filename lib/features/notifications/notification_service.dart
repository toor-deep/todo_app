import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'data/model/notifications_local_model/notification_model.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    try {
      String deviceTimeZone = await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(tz.getLocation(deviceTimeZone));
      debugPrint("✅ Local timezone set: $deviceTimeZone");
    } catch (e) {
      debugPrint("⚠️ Could not get device timezone, defaulting to UTC: $e");
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

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

  //Task reminder notifications
  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTZDate = tz.TZDateTime.from(scheduledDate, tz.local);

    if (scheduledTZDate.isBefore(now)) {
      scheduledTZDate = scheduledTZDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminder Notifications',
      channelDescription: 'Scheduled reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const notifDetails = NotificationDetails(android: androidDetails);

    print("📌 Now (Local): ${now.hour}:${now.minute}");
    print("📌 Scheduled at: $scheduledDate");

    await _localNotif.zonedSchedule(
      id,
      title,
      body,
      scheduledTZDate,
      notifDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
}

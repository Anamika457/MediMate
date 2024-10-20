
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz; 
import 'package:timezone/data/latest.dart' as tz_data; 
import 'package:permission_handler/permission_handler.dart';

// Request notification permission
Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
}

// Notification service class
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  Future<void> initNotification() async {
    // Initialize timezone data
    tz_data.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('flutter_logo');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    try {
      await notificationsPlugin.zonedSchedule(
  0,
  'Test Notification',
  'This is a test notification.',
  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)), 
  await notificationDetails(),
  // ignore: deprecated_member_use
  androidAllowWhileIdle: true,
  uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
);

      print('Notification scheduled for $scheduledTime');
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }
}
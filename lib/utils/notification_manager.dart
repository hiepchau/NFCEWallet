import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nfc_e_wallet/main.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp();
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FCMToken = (await messaging.getToken())!;
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        showNotification(
            id: 1,
            title: initialMessage.data["title"],
            body: initialMessage.data["body"]);
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(
            id: 1, title: message.data["title"], body: message.data["body"]);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        showNotification(
            id: 1, title: message.data["title"], body: message.data["body"]);
      });
    }
  }

  static Future<void> initialize() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'my_channel_id',
      'My Notification Channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

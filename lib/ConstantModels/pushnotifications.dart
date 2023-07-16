import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCM {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configureFCM() async {
    // Request permission for FCM
    String? fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Save the FCM token
      String? fcmToken = await _firebaseMessaging.getToken();
      print('FCM Token: $fcmToken');

      // Configure notification handling
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Handle incoming FCM messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received FCM message: ${message.notification?.title}');
        _showNotification(
          message.notification?.title ?? '',
          message.notification?.body ?? '',
        );
      });

      // Handle FCM messages when the app is in the background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Opened FCM message: ${message.notification?.title}');
        // Handle navigation to a specific screen based on the notification
      });
    }
  }

  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '123',
      'quickee_notifications',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
   );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

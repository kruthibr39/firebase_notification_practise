import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification_practise/main.dart';
import 'package:firebase_notification_practise/notification_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title ${message.notification?.title}');
  print('Desc ${message.notification?.body}');
  print('Payload ${message.data}');
}
class PushNotifications{
  final FirebaseMessaging _fm = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'High-Importance',
    importance : Importance.defaultImportance

  );

  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message){
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future initPN() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound : true
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message){
      final notification = message.notification;

      if (notification == null) return;

      _localNotification.show(notification.hashCode, notification.title, notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(_androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@drawable/ic_launcher',
        )
      ),
          payload: jsonEncode(message.toMap())
      );
    });
  }

  Future initLocalNotifications() async{
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // Extract the payload (which is passed as a string) from the notification response
        final payload = notificationResponse.payload;

        if (payload != null) {
          // Decode the payload to a map, assuming the payload is a JSON string
          final messageMap = jsonDecode(payload) as Map<String, dynamic>;

          // Create a RemoteMessage from the decoded data
          final message = RemoteMessage.fromMap(messageMap);

          // Handle the message as needed
          handleMessage(message);
        }
      },
    );

    final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }


  Future<void> initNotifications() async{
    await _fm.requestPermission();
    final token = await _fm.getToken();
    print('hi');
    print(token);
    initPN();
    initLocalNotifications();
  }
}

/*
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationService {
  final FirebaseMessaging _fm = FirebaseMessaging.instance;

  Future<void> backgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print('Handling a background message ${message.messageId}');
    }
  }

  Future<String?> getToken() async {
    String? token = await _fm.getToken();
    if (kDebugMode) {
      print(token);
    }
    return token;

  }

  Future initialize() async{
    _fm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      if (kDebugMode) {
        print('Got a message');
      }
      if (kDebugMode) {
        print('Message data : ${message.data}');
      }
    });
    
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    await getToken();
  }


}
*
 */
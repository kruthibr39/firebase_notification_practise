import 'package:firebase_notification_practise/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_notification_practise/push_notifications.dart';
import 'package:firebase_notification_practise/notification_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotifications().initNotifications();
  runApp(
     MaterialApp(
       navigatorKey: navigatorKey,
       home:  const MyHomePage(),
       routes: {
         NotificationScreen.route : (context) => const NotificationScreen(),
       },
     )
  );
}




/*import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:firebase_notification_practise/home.dart';
import 'package:firebase_notification_practise/push_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PushNotificationService _notificationService = PushNotificationService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _notificationService.initialize();

    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


Future<void> _backgroundHandler(RemoteMessage message) async {
  // Handle background message
  print('Handling a background message ${message.messageId}');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Firebase Notifications')),
        body: NotificationWidget(),
      ),
    );
  }
}
class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}
class _NotificationWidgetState extends State<NotificationWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Waiting for messages'),
    );
  }
}
*/

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget{
  const NotificationScreen({super.key});
  static const route = '/notification_screen';

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notification Screen'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Hello Notification Page'),
              SizedBox(height: 20),
              Text('Title: ${message.notification?.title ?? "No Title"}'),
              Text('Desc: ${message.notification?.body ?? "No Description"}'),
              SizedBox(height: 20),
              Text('Data: ${message.data.isNotEmpty ? message.data.toString() : "No Data"}'),
            ],
          ),
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notification Practise'),
        ),
        body: Center(
          child: Text('Test'),
        ),
      )
    );
  }
}
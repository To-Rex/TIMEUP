import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';
import 'firebase_api.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        FireBaseApi.token = token;
      });
      print('token: $token');
    });

    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      final notification = message.notification;
      setState(() {
        messages.add(Message(
          title: notification?.title ?? '',
          body: notification?.body ?? '',
        ));
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: $message');
      final notification = message.notification;
      setState(() {
        messages.add(Message(
          title: notification?.title ?? '',
          body: notification?.body ?? '',
        ));
      });
    });

  }

  @override
  Widget build(BuildContext context) => ListView(
    children: messages.map(buildMessage).toList(),
  );

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons/heroicons.dart';
import '../models/message.dart';
import 'firebase_api.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final List<NotificationModel> messages = [];

  @override
  void initState() {
    final box = GetStorage();
    //read all notification
    var list = box.read('notification');
    list ??= [];
    print(list.length);
    print(list);
    for (var i = 0; i < list.length; i++) {
      messages.add(NotificationModel.fromJson(list[i]));
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    print(GetStorage().read('getttt'));
    print('=-=-=-=-=-=-=-=-=-=-==-=-=-=-= ${GetStorage().read('getttt')}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: HeroIcon(
              HeroIcons.chevronLeft,
              size: w * 0.07,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Eslatmalar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index].title ?? ''),
            subtitle: Text(messages[index].body ?? ''),
          );
        },
      ),
    );
  }
}
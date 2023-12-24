import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/firebase_options.dart';

class FireBaseApi {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  Future<void> initNotification() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await messaging.requestPermission();
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await messaging.getToken();
    print('fcmTokenssss: $fcmToken');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Handling a foreground message ${message.messageId}');
      print('Handling a foreground message ${message.data}');
      print('Handling a foreground message ${message.notification}');
      print('Handling a foreground message ${message.notification!.body}');
      print('Handling a foreground message ${message.notification!.title}');
      print('Handling a foreground message ${message.notification!.android!.imageUrl}');
      final box = GetStorage();
      var list = box.read('notification');
      var notification = NotificationModel(
        title: message.notification!.title,
        body: message.notification!.body,
        token: message.data['token'],
        image: message.notification!.android!.imageUrl,
      );
      if (list != null) {
        list.add(notification.toJson());
        box.write('notification', list);
        print(list);
      } else {
        list = [];
        list.add(notification.toJson());
        box.write('notification', list);
        print(list);
      }
      print(list);
    });
  }
}

class NotificationList {
  final List<NotificationModel>? notificationList;

  NotificationList({
    this.notificationList,
  });

  factory NotificationList.fromJson(List<dynamic> json) {
    List<NotificationModel> notificationList = [];
    notificationList = json.map((e) => NotificationModel.fromJson(e)).toList();
    return NotificationList(
      notificationList: notificationList,
    );
  }

  Map<String, dynamic> toJson() => {
    'notificationList': notificationList,
  };

  NotificationList copyWith({
    List<NotificationModel>? notificationList,
  }) {
    return NotificationList(
      notificationList: notificationList ?? this.notificationList,
    );
  }

  @override
  String toString() => 'NotificationList(notificationList: $notificationList)';
}

class NotificationModel {
  final String? title;
  final String? body;
  final String? token;
  final String? image;

  NotificationModel({
    this.title,
    this.body,
    this.token,
    this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      token: json['token'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
    'token': token,
    'image': image,
  };

  NotificationModel copyWith({
    String? title,
    String? body,
    String? token,
    String? image,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
      token: token ?? this.token,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'NotificationModel(title: $title, body: $body, token: $token, image: $image)';
  }
}
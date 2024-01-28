import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/firebase_options.dart';

class FireBaseApi {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  late AndroidNotificationChannel channel;


  //initNotification topic get notification. topic name: some-topic
  Future<void> initNotificationTopic() async {
    var myTopic = GetStorage().read('myTopic').toString();
    if (myTopic != null) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await messaging.requestPermission();
      await messaging.subscribeToTopic(myTopic);
      await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      final fcmToken = await messaging.getToken();
      print('fcmTokenssss: $fcmToken');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('oneeee ${message.messageId}');
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        print('twoooo ${message.messageId}');
      });
      //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
        if (message != null) {
          print('threeee ${message.messageId}');
        }
      });
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await messaging.requestPermission();
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    print('Handling a background message ${message.messageId}');
    print('Handling a background message ${message.data}');
    print('Handling a background message ${message.notification}');
    print('Handling a background message ${message.notification!.body}');
    print('Handling a background message ${message.notification!.title}');
    print('Handling a background message ${message.notification!.android!.imageUrl}');

  }
}

class InitNotification {
  static Future<void> initialize() async {
    var myTopic = GetStorage().read('myTopic').toString();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic(myTopic);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcmTokenssss: $fcmToken');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('oneeee ${message.messageId}');
      if (message.notification!.body != null) {
        showNotification(message);
      } else {
        showNotificationWithNoBody(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('twoooo ${message.messageId}');
    });
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        print('threeee ${message.messageId}');
      }
    });

    await _configureNotificationChannels();
  }

  static Future<void> _configureNotificationChannels() async {
    // Configure notification channels for Android
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background message here
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (message.notification!.body != null) {
      showNotification(message);
    } else {
      showNotificationWithNoBody(message);
    }
    print("Handling a background message: ${message.messageId}");
  }

  static Future<void> showNotification(RemoteMessage message) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message.notification!.title, message.notification!.body, platformChannelSpecifics,
        payload: 'item x');
  }
  static Future<void> showNotifications(title, body) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'item x');
  }


  static Future<void> showNotificationWithNoBody(RemoteMessage message) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message.notification!.title, '', platformChannelSpecifics,
        payload: 'item x');
  }
}

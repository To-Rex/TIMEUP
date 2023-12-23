import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  Future<void> initNotification() async {
    await messaging.requestPermission();
    final fcmToken = await messaging.getToken();
    print('fcmToken: $fcmToken');
  }
}
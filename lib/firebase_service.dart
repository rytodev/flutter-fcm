import 'package:firebase_messaging/firebase_messaging.dart';
import 'main.dart';
import 'notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseService {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage message) {
    print('title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
    print('payload: ${message.data}');

    navigatorKey.currentState
        ?.pushNamed(NotificationScreen.route, arguments: message);
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.onMessage.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token : $fcmToken'); //device token
    await initPushNotifications();
  }
}

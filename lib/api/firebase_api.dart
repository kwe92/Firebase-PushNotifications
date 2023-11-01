import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/main.dart';
import 'package:firebase_notifications/views/notification_view.dart';
import 'package:flutter/material.dart';

/// FirebaseApi: responsible for handling all motification logic
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // request permissions from the user
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Firebase Cloud Messaging Token: identifier for device in app
    // used to send notification to the device uniquely
    // Typically saved in a database along side the user entity
    final fCMToken = await _firebaseMessaging.getToken();

    debugPrint("FCM Token: $fCMToken");

    initPushNotifications();
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Payload: ${message.data}');
  }

  static Future<void> handleMessage(RemoteMessage? message) async {
    // if the message is null exit method
    if (message == null) {
      return;
    }

    // send the message to the navigation view and navigate to it
    navigatorKey.currentState?.pushNamed(
      NotificationView.route,
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    // Foreground notification Apple device presentation options
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Performs an action when the app is opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Performs an action when the app is opened from the background state
    FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));

    // Allows the app to receive notifications in background and terminated states
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}


    // TODO: Research: FirebaseMessaging.onMessage.listen
    // FirebaseMessaging.onMessage.listen(
    //   (RemoteMessage message) async {
    //     debugPrint('FCM OnMessage');
    //     handleBackgroundMessage(message);
    //   },
    // );
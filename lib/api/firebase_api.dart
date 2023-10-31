import 'package:firebase_messaging/firebase_messaging.dart';
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

    // Firebase Cloud Messaging Token: identifier for device in app | used to send notification to the device | Typically saved in a database along side the user entity
    final fCMToken = await _firebaseMessaging.getToken();

    debugPrint("FCM Token: $fCMToken");

    // Allows you to receive notifications in the background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint('FCM OnMessage');
        handleBackgroundMessage(message);
      },
    );
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Payload: ${message.data}');
  }
}

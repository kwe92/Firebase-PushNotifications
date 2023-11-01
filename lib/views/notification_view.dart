import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  static const route = "/notification-view";

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notifications"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${message.notification?.title}'),
          const SizedBox(height: 6),
          Text('${message.notification?.body}'),
          const SizedBox(height: 6),
          Text('${message.data}'),
        ],
      ),
    );
  }
}

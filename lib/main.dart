import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notifications/api/firebase_api.dart';
import 'package:firebase_notifications/firebase_options.dart';
import 'package:firebase_notifications/views/home_view.dart';
import 'package:firebase_notifications/views/notification_view.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Push Notifications',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurpleAccent,
          ),
        ),
        home: const HomeView(),
        navigatorKey: navigatorKey,
        routes: _routeMap,
      );
}

Map<String, WidgetBuilder> _routeMap = {
  NotificationView.route: (context) => const NotificationView(),
};

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: const Text(
            "Push Notifications",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: Center(
          child: Text(
            "home".toUpperCase(),
            style: const TextStyle(
              fontSize: 40,
              color: Colors.blueAccent,
            ),
          ),
        ),
      );
}

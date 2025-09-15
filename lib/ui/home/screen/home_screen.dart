import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../signUp/screen/signUp_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(
                context,
                SignUpScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}

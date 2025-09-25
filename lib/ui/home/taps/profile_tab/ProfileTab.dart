import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed:() {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LogInScreen.routeName);
              },
              icon:Icon(
                  Icons.logout
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/signIn/screen/signIn_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorManger.primaryColor,
        title: Text('Register', style: TextStyle(color: ColorManger.white)),
        iconTheme: IconThemeData(color: ColorManger.white),
      ),
      body: Center(
        child: Text(
          'Register Screen',
          style: TextStyle(color: ColorManger.white, fontSize: 24),
        ),
      ),
    );
  }
}

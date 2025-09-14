import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/signUp/screen/signUp_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Image.asset(AssetsManager.movieLogo),
      ).animate(
        onComplete: (controller){
          Navigator.pushReplacementNamed(context,SignUpScreen.routeName);
        }
      ).scale(duration: Duration(seconds: 2)),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/home/screen/home_screen.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';
import 'package:movies_app/ui/signUp/screen/signUp_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Image.asset(
          AssetsManager.movieLogo,
          width: 200.w,
          height: 200.h,
        ),
      ).animate(
        onComplete: (controller) {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.pushReplacementNamed(context, LogInScreen.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        },
      ).scale(duration: const Duration(seconds: 2)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies_app/ui/signIn/screen/signIn_screen.dart';
import 'package:movies_app/ui/splash/screen/splash_screen.dart';
import 'package:movies_app/ui/start/screen/start_screen.dart';
import 'ui/homePage/home_page.dart';
import 'ui/onboarding/screen/screen/onboarding_page.dart';
import 'ui/onboarding/screen/widgets/onboarding_process.dart';
import 'package:movies_app/ui/register/register_screen/register_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> getSeenOnboarding() async {
    return await OnboardingProcess.hasSeenOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        StartScreen.routeName: (_) => const StartScreen(),
        HomePage.routeName: (_) =>  HomePage(),
        OnBoardingPage.routeName: (_) => const OnBoardingPage(),
        SignInScreen.routeName: (_) => const SignInScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:movies_app/ui/splash/screen/splash_screen.dart';
import 'package:movies_app/ui/start/screen/start_screen.dart';
import 'home_page.dart';
import 'ui/onboarding/screen/screen/onboarding_page.dart';
import 'onboarding_process.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? seenOnboarding;

  @override
  void initState() {
    super.initState();
    checkOnboarding();
  }

  void checkOnboarding() async {
    bool seen = await OnboardingProcess.hasSeenOnboarding();
    if (!mounted) return;
    setState(() => seenOnboarding = seen);
  }

  @override
  Widget build(BuildContext context) {
    if (seenOnboarding == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      home: seenOnboarding! ? HomePage() : OnBoardingPage(),
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        StartScreen.routeName: (_) => const StartScreen(),
        HomePage.routeName: (_) => HomePage(),
        OnBoardingPage.routeName: (_) => OnBoardingPage(),
      },
    );
  }
}

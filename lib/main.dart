import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:movies_app/ui/home/screen/home_screen.dart';
import 'package:movies_app/ui/home/taps/home_tab/HomeTab.dart';
import 'package:movies_app/ui/home/taps/profile_tab/edit_profile_screen/edit_profile_screen.dart';
import 'package:movies_app/ui/home/taps/profile_tab/profile_screen/ProfileTab.dart';
import 'package:movies_app/ui/home/taps/search_tab/SearchTab.dart';
import 'package:movies_app/ui/home/taps/sort_tap/SortTab.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';
import 'package:movies_app/ui/signUp/screen/signUp_screen.dart';
import 'package:movies_app/ui/splash/screen/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      fallbackLocale: Locale('en'),
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        LogInScreen.routeName: (_) => LogInScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        HomeTab.routeName: (_) => HomeTab(),
        SortTab.routeName: (_) => SortTab(),
        SearchTab.routeName: (_) => SearchTab(),
        EditProfileScreen.routeName: (_) => EditProfileScreen(),
        ProfileTab.routeName: (_) => ProfileTab(),
      },
    );
  }
}




import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/PrefsManager.dart';
import 'package:movies_app/ui/home/screen/home_screen.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';
import 'package:movies_app/ui/movie_details/screen/movie_details_screen.dart';
import 'package:movies_app/ui/signUp/screen/signUp_screen.dart';
import 'package:movies_app/ui/splash/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        MovieDetailsScreen.routeName: (context) {
          final movieId = ModalRoute.of(context)!.settings.arguments as int;
          return MovieDetailsScreen(movieId: movieId);
        },
      },
    );
  }
}

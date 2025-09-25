import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/PrefsManager.dart';
import 'package:movies_app/ui/home/screen/home_screen.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';
import 'package:movies_app/ui/movie_details/screen/movie_details_screen.dart';
import 'package:movies_app/ui/signUp/screen/signUp_screen.dart';
import 'package:movies_app/ui/splash/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:movies_app/ui/onboarding/screen/screen/onboarding_page.dart';



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
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (_) => SplashScreen(),
            OnBoardingPage.routeName: (_) => OnBoardingPage(),
            SignUpScreen.routeName: (_) => SignUpScreen(),
            LogInScreen.routeName: (_) => LogInScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            MovieDetailsScreen.routeName: (context) {
              final movieId = ModalRoute.of(context)!.settings.arguments as int;
              return MovieDetailsScreen(movieId: movieId);
            },
          },
        );
      },
    );
  }
}

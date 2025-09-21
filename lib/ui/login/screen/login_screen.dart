import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/DialogUtils.dart';
import 'package:movies_app/ui/home/screen/home_screen.dart';
import 'package:movies_app/ui/signUp/screen/signUp_screen.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/ColorManager.dart';
import '../../../core/resources/Constans.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = 'logIn';

  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedLanguage = 0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == "ar") {
      selectedLanguage = 1;
    }

    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: AppBar(
        title: Text(
          "login".tr(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: ColorManager.yellow,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Avatars

              Image.asset(AssetsManager.movieLogo),
              const SizedBox(height: 69),



              // Email
              CustomField(
                isPassword: false,
                hint: 'email'.tr(),
                keyboard: TextInputType.emailAddress,
                controller: emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "emailReq".tr();
                  }
                  if (!RegExp(emailRegex).hasMatch(value)) {
                    return "emailInvalid".tr();
                  }
                  return null;
                },
                prefix: AssetsManager.email,
              ),
              const SizedBox(height: 24),

              // Password
              CustomField(
                isPassword: true,
                hint: 'password'.tr(),
                keyboard: TextInputType.visiblePassword,
                controller: passwordController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "passReq".tr();
                  }
                  if (value.length < 6) {
                    return "passWeak".tr();
                  }
                  return null;
                },
                prefix: AssetsManager.password,
              ),
              const SizedBox(height: 33),



              // Log In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.yellow,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'login'.tr(),
                    style: TextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 23),

              // have acc
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "donotHaveAcc".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Text(
                      "createOne".tr(),
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 23),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    child: Divider(
                      color: ColorManager.yellow,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'or'.tr(),
                    style: TextStyle(color: ColorManager.yellow, fontSize: 14),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 90,
                    child: Divider(
                      color: ColorManager.yellow,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // login with google
              // Google Login Button (UI only)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    /// LOGIC HERE
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorManager.yellow),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: ColorManager.yellow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsManager.google,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Login with Google",
                        style: TextStyle(
                          color: ColorManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Language Switch
              CustomSwitch(
                onChange: (value) {
                  setState(() {
                    selectedLanguage = value;
                  });
                  if (selectedLanguage == 1) {
                    context.setLocale(const Locale("ar"));
                  } else {
                    context.setLocale(const Locale("en"));
                  }
                },
                icons: [
                  SvgPicture.asset(AssetsManager.us, height: 30, width: 30),
                  SvgPicture.asset(AssetsManager.eg, height: 30, width: 30),
                ],
                current: selectedLanguage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      DialogUtils.showLoadingDialog(context);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      String message = "";
      if (e.code == 'user-not-found') {
        message = "noUserFound".tr();
      } else if (e.code == 'wrong-password') {
        message = "wrongPassword".tr();
      } else if (e.code == 'invalid-email') {
        message = "invalidEmail".tr();
      } else {
        message = "unknownError".tr();
      }

      DialogUtils.showMessage(
        context,
        message,
        title: "Error",
        posActionName: "OK",
      );
    }
  }
}

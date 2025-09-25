import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        scrolledUnderElevation: 0,
        title: Text(
          "login".tr(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: ColorManager.yellow,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  AssetsManager.movieLogo,
                  width: 120.w,
                  height: 120.h,
                ),
                SizedBox(height: 69.h),
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
                SizedBox(height: 24.h),
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
                SizedBox(height: 33.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.yellow,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'login'.tr(),
                      style: TextStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 23.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "donotHaveAcc".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
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
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 23.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Divider(
                        color: ColorManager.yellow,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'or'.tr(),
                      style: TextStyle(
                        color: ColorManager.yellow,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 90.w,
                      child: Divider(
                        color: ColorManager.yellow,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ColorManager.yellow),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      backgroundColor: ColorManager.yellow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsManager.google,
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Login with Google",
                          style: TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
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
                    SvgPicture.asset(
                      AssetsManager.us,
                      height: 30.h,
                      width: 30.w,
                    ),
                    SvgPicture.asset(
                      AssetsManager.eg,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ],
                  current: selectedLanguage,
                ),
              ],
            ),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/DialogUtils.dart';
import 'package:movies_app/ui/home/screen/home_screen.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/ColorManager.dart';
import '../../../core/resources/Constans.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signUp';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedLanguage = 0;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
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
          "register".tr(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: ColorManager.yellow,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: AssetImage(AssetsManager.avatar1),
                    ),
                    SizedBox(width: 16.w),
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage(AssetsManager.avatar2),
                    ),
                    SizedBox(width: 16.w),
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: AssetImage(AssetsManager.avatar3),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'avatar'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(height: 24.h),
                CustomField(
                  isPassword: false,
                  hint: 'name'.tr(),
                  keyboard: TextInputType.name,
                  controller: nameController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "nameReq".tr();
                    }
                    return null;
                  },
                  prefix: AssetsManager.name,
                ),
                SizedBox(height: 24.h),
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
                SizedBox(height: 24.h),
                CustomField(
                  isPassword: true,
                  hint: 'confirmPassword'.tr(),
                  keyboard: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "confirmReq".tr();
                    }
                    if (value != passwordController.text) {
                      return "passNotMatch".tr();
                    }
                    return null;
                  },
                  prefix: AssetsManager.password,
                ),
                SizedBox(height: 24.h),
                CustomField(
                  isPassword: false,
                  hint: 'phone'.tr(),
                  keyboard: TextInputType.phone,
                  controller: phoneController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "phoneReq".tr();
                    }
                    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                      return "phoneInvalid".tr();
                    }
                    return null;
                  },
                  prefix: AssetsManager.phone,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await createAccount();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.yellow,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'createAcc'.tr(),
                      style: TextStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 17.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "haveAcc".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LogInScreen.routeName);
                      },
                      child: Text(
                        "login".tr(),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
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
                    SvgPicture.asset(AssetsManager.us, height: 30.h, width: 30.w),
                    SvgPicture.asset(AssetsManager.eg, height: 30.h, width: 30.w),
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

  Future<void> createAccount() async {
    try {
      DialogUtils.showLoadingDialog(context);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String message = "";
      if (e.code == 'weak-password') {
        message = "weakPassword".tr();
      } else if (e.code == 'email-already-in-use') {
        message = "emailInUse".tr();
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

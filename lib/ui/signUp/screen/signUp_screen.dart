import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/DialogUtils.dart';
import 'package:movies_app/ui/home/screen/home_screen.dart';

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
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
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
      appBar: AppBar(
        title:  Text(
          "register".tr(),
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
        color: ColorManager.primaryColor,
        padding: const EdgeInsets.all(16),
        child: Form(
         key: formKey,
        child: SingleChildScrollView(
          child: Column(
          
            children: [
              // Avatars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(AssetsManager.avatar1),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(AssetsManager.avatar2),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(AssetsManager.avatar3),
                  ),
                ],
              ),
              const SizedBox(height: 10),
               Text(
                'avatar'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: ColorManager.white,
                ),
              ),
              const SizedBox(height: 24),
          
              // Name
              CustomField(
                isPassword: false,
                hint: 'name'.tr(),
                keyboard: TextInputType.name,
                controller: nameController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name can't be empty";
                  }
                  return null;
                },
                prefix: AssetsManager.name,
              ),
              const SizedBox(height: 24),
          
              // Email
              CustomField(
                isPassword: false,
                hint: 'email'.tr(),
                keyboard: TextInputType.emailAddress,
                controller: emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email can't be empty";
                  }
                  if (!RegExp(emailRegex).hasMatch(value)) {
                    return "Email not valid";
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
                    return "Password can't be empty";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
                prefix: AssetsManager.password,
              ),
              const SizedBox(height: 24),
          
              // Confirm Password
              CustomField(
                isPassword: true,
                hint: 'confirmPassword'.tr(),
                keyboard: TextInputType.visiblePassword,
                controller: confirmPasswordController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your password";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                prefix: AssetsManager.password,
              ),
              const SizedBox(height: 24),
          
              // Phone Number
              CustomField(
                isPassword: false,
                hint: 'phone'.tr(),
                keyboard: TextInputType.phone,
                controller: phoneController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone can't be empty";
                  }
                  if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                    return "Phone not valid";
                  }
                  return null;
                },
                prefix: AssetsManager.phone,
              ),
          
              const SizedBox(height: 32),
          
              // Sign Up Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint("Name: ${nameController.text}");
                    debugPrint("Email: ${emailController.text}");
                    debugPrint("Password: ${passwordController.text}");
                    debugPrint(
                        "Confirm Password: ${confirmPasswordController.text}");
                    debugPrint("Phone: ${phoneController.text}");
                    if (formKey.currentState!.validate()) {
                      await createAccount();

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.yellow,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child:  Text(
                    'createAcc'.tr(),
                    style: TextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 17),
          
              // have acc
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "haveAcc".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:  Text(
                      "login".tr(),
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 24),
          
              /// Language Switch
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
    )
    );
  }
  createAccount()async{
   try{
     DialogUtils.showLoadingDialog(context);
     var credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text
     );
     print(credential.user?.uid);
     Navigator.pop(context);
     Navigator.pushNamed(context, HomeScreen.routeName);

   }on FirebaseAuthException catch (e) {
     Navigator.pop(context);
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   }
   }
}

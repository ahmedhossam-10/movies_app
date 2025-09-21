import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/homePage/home_page.dart';
import 'package:movies_app/ui/signIn/widgets/custom_text_field.dart';
import 'package:movies_app/ui/register/register_screen/register_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in';
  const SignInScreen({super.key});
  @override
  State<SignInScreen>createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManger.primaryColor,
        body:SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(AssetsManager.movieLogo),
                    CustomTextField(hintText: 'Email',
                      svgIcon: 'assets/icons/email icon.svg',),
                    SizedBox(height: 16,),
                    CustomTextField(hintText: 'Password',isPassword: true,
                      svgIcon: 'assets/icons/lock icon.svg',),
                    SizedBox(height: 26,),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManger.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
            
                              ),
                              onPressed: (){
                            if(_formKey.currentState!.validate()){
                              Navigator.pushReplacementNamed(context,HomePage.routeName);
                            }
                          }, child: Text('Login',style: TextStyle(color: ColorManger.darkGray),)),
                        ),
                      ],
                    ),
                    SizedBox(height: 26,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t Have Account ? ',
                          style: TextStyle(color: ColorManger.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterScreen.routeName);
                          },

                          child: Text(
                            'Create One',
                            style: TextStyle(color: ColorManger.yellow,
                            fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          child: Divider(
                            color: ColorManger.yellow,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'OR',
                          style: TextStyle(color: ColorManger.yellow, fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 90, //
                          child: Divider(
                            color: ColorManger.yellow,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26,),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManger.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              // هنا هتحط كود تسجيل الدخول بجوجل
                            },
                            label: Text(
                              'Login With Google',
                              style: TextStyle(
                                color: ColorManger.darkGray,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
            
                  ],
                ),
              ),
            ),
          ),
        ),



    );
  }
}

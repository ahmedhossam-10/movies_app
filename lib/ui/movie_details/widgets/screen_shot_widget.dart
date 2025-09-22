import 'package:flutter/material.dart';

class ScreenShotWidget extends StatelessWidget {
  String pic;
   ScreenShotWidget({super.key,required this.pic});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent
      ),
      child: Image.asset(pic,fit: BoxFit.fill,height: 167,),
    );
  }
}

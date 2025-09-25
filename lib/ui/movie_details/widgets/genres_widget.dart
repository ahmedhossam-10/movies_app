import 'package:flutter/material.dart';

import '../../../core/resources/ColorManager.dart';

class GenresWidget extends StatelessWidget {
  String text;
   GenresWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
            color: ColorManager.darkGray
      ),
      child: Text(text,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.white),),
    );
  }
}

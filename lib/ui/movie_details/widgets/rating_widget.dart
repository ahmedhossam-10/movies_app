import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';

class RatingWidget extends StatelessWidget {
  String picture;
  String text;
   RatingWidget({super.key,required this.text,required this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff282A28),
      ),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),

      child: Row(
        children: [
          SvgPicture.asset(picture),
          SizedBox(width: 14,),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

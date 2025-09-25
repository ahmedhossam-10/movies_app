import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';

class RatingWidget extends StatelessWidget {
  final String picture;
  final String text;

  const RatingWidget({
    super.key,
    required this.text,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xff282A28),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
        horizontal: 20.w,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            picture,
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}

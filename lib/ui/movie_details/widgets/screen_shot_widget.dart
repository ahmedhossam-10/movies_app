import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenShotWidget extends StatelessWidget {
  final String pic;

  const ScreenShotWidget({super.key, required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          pic,
          fit: BoxFit.fill,
          height: 167.h,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.broken_image, size: 50.sp, color: Colors.grey),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: 167.h,
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

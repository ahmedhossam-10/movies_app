import 'package:flutter/material.dart';

class ScreenShotWidget extends StatelessWidget {
  final String pic;

  const ScreenShotWidget({super.key, required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          pic,
          fit: BoxFit.fill,
          height: 167,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.broken_image, size: 50),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BigMovieCard extends StatelessWidget {
  final String imagePath;
  final double rating;

  const BigMovieCard({
    super.key,
    required this.imagePath,
    this.rating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath), // هنا هنستخدم الـ AssetsManager
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

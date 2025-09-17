import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/resources/AssetsManager.dart';
import '../../widgets/big_movie_card.dart';
import '../../widgets/small_movie_card.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  final List<String> movies = [
    AssetsManager.movie1,
    AssetsManager.movie2,
    AssetsManager.movie3,
  ];

  final List<double> ratings = [7.7, 8.0, 7.9];

  final PageController _pageController = PageController(viewportFraction: 0.75);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// الجزء الأول (خلفية + blur + الكروت)
            SizedBox(
              height: 500, // ارتفاع الجزء الأول
              child: Stack(
                children: [
                  /// الخلفية
                  Positioned.fill(
                    child: Image.asset(
                      movies[selectedIndex],
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// blur تحت الكروت
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 200,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),

                  /// الكروت + Available Now
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      Image.asset(
                        AssetsManager.Available_Now,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 260,
                        child: PageView.builder(
                          itemCount: movies.length,
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            double scale =
                            selectedIndex == index ? 1.0 : 0.85;

                            return TweenAnimationBuilder(
                              tween: Tween<double>(
                                  begin: scale, end: scale),
                              duration:
                              const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: BigMovieCard(
                                      imagePath: movies[index],
                                      rating: ratings[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// الجزء اللي بعد البلور (خلفية سودا)
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// Watch Now
                  Image.asset(
                    AssetsManager.Watch_Now,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SmallMovieCard(
                            imagePath: AssetsManager.movie2, rating: 8.0),
                        SmallMovieCard(
                            imagePath: AssetsManager.movie3, rating: 7.9),
                        SmallMovieCard(
                            imagePath: AssetsManager.movie1, rating: 7.7),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

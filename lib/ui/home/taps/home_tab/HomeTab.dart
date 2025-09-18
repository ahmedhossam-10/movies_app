import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    movies[selectedIndex],
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      AssetsManager.Available_Now,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 12),

                    CarouselSlider(
                      items: movies.asMap().entries.map((entry) {
                        int index = entry.key;
                        String movie = entry.value;

                        return BigMovieCard(
                          imagePath: movie,
                          rating: ratings[index],
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 280,
                        viewportFraction: 0.65,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Image.asset(
                    AssetsManager.Watch_Now,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

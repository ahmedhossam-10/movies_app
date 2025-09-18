import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/home/taps/sort_tap/SortTab.dart';
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

                        return AspectRatio(
                          aspectRatio: 4 / 5,
                          child: BigMovieCard(
                            imagePath: movie,
                            rating: ratings[index % ratings.length],
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 0.55,
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Action".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context,SortTab.routeName);
                          },
                          child:Text(
                            "See More".tr(),
                            style: TextStyle(
                              color: ColorManager.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 3 / 4,
                          child: SmallMovieCard(
                            imagePath: movies[index],
                            rating: ratings[index % ratings.length],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Adventure".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context,SortTab.routeName);
                          },
                          child:Text(
                            "See More".tr(),
                            style: TextStyle(
                              color: ColorManager.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 3 / 4,
                          child: SmallMovieCard(
                            imagePath: movies[index],
                            rating: ratings[index % ratings.length],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Animation".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context,SortTab.routeName);
                          },
                          child:Text(
                            "See More".tr(),
                            style: TextStyle(
                              color: ColorManager.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 3 / 4,
                          child: SmallMovieCard(
                            imagePath: movies[index],
                            rating: ratings[index % ratings.length],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Biography".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context,SortTab.routeName);
                          },
                          child:Text(
                            "See More".tr(),
                            style: TextStyle(
                              color: ColorManager.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 3 / 4,
                          child: SmallMovieCard(
                            imagePath: movies[index],
                            rating: ratings[index % ratings.length],
                          ),
                        );
                      },
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

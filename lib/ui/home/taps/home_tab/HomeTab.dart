import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import '../../../../core/resources/AssetsManager.dart';
import '../../../../core/remote/network/ApiManager.dart';
import '../../widgets/big_movie_card.dart';
import '../../widgets/small_movie_card.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback? onSeeMoreTap;

  const HomeTab({super.key, this.onSeeMoreTap});

  static const String routeName = 'homeTab';

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;


  final List<String> topMovies = [
    AssetsManager.movie1,
    AssetsManager.movie2,
    AssetsManager.movie3,
  ];

  final List<double> topRatings = [7.7, 8.0, 7.9];

  final Color backgroundColor = const Color(0xFF121312);


  final List<String> categories = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  topMovies[selectedIndex],
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
                        backgroundColor.withOpacity(0.3),
                        backgroundColor.withOpacity(0.6),
                        backgroundColor.withOpacity(0.9),
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
                    items: topMovies.asMap().entries.map((entry) {
                      int index = entry.key;
                      String movie = entry.value;

                      return AspectRatio(
                        aspectRatio: 4 / 5,
                        child: BigMovieCard(
                          imagePath: movie,
                          rating: topRatings[index % topRatings.length],
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
            color: backgroundColor,
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

                ...categories.map((genre) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCategoryRow(context, genre.tr(),
                          onTap: widget.onSeeMoreTap),
                      buildMovieListFromApi(genre),
                    ],
                  );
                }).toList(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryRow(BuildContext context, String title,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: onTap ?? () {},
            child: Text(
              "See More".tr(),
              style: TextStyle(
                color: ColorManager.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMovieListFromApi(String genre) {
    final String apiGenre = genre.toLowerCase();

    return SizedBox(
      height: 220,
      child: FutureBuilder<List<dynamic>>(
        future: ApiManager.getMoviesByGenreAndLimit(apiGenre),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading $genre movies",
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No movies found",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final movies = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final movie = movies[index] as Map<String, dynamic>;

              final String imageUrl =
                  (movie["medium_cover_image"] as String?) ?? AssetsManager.movie1;

              final double rating = (movie["rating"] is num)
                  ? (movie["rating"] as num).toDouble()
                  : 0.0;

              return AspectRatio(
                aspectRatio: 3 / 4,
                child: SmallMovieCard(
                  imagePath: imageUrl,
                  rating: rating,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

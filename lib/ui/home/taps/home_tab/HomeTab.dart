import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import '../../../../core/resources/AssetsManager.dart';
import '../../../../core/remote/network/ApiManager.dart';
import '../../../movie_details/screen/movie_details_screen.dart';
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
                  height: 0.4.sh,
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
                  SizedBox(height: 80.h),
                  Image.asset(
                    AssetsManager.Available_Now,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12.h),
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
                      height: 0.35.sh,
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
                SizedBox(height: 16.h),
                Image.asset(
                  AssetsManager.Watch_Now,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 12.h),
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
                SizedBox(height: 24.h),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: onTap ?? () {},
            child: Text(
              "See More".tr(),
              style: TextStyle(
                color: ColorManager.yellow,
                fontSize: 16.sp,
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
      height: 220.h,
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
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No movies found",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            );
          }

          final movies = snapshot.data!;

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final movie = movies[index] as Map<String, dynamic>;

              final String imageUrl =
                  (movie["medium_cover_image"] as String?) ?? AssetsManager.movie1;

              final double rating = (movie["rating"] is num)
                  ? (movie["rating"] as num).toDouble()
                  : 0.0;

              final int movieId = movie["id"] ?? 0;

              return GestureDetector(
                onTap: () {
                  print("Selected Movie ID: $movieId");
                  Navigator.pushNamed(
                    context,
                    MovieDetailsScreen.routeName,
                    arguments: movieId,
                  );
                },
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: SmallMovieCard(
                    imagePath: imageUrl,
                    rating: rating,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/movie_details/widgets/cast_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/genres_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/rating_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/screen_shot_widget.dart';

import '../../../core/remote/network/ApiManager.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'details';
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [SvgPicture.asset("assets/svg/save.svg")],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: ApiManager.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                "No details found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final movie = snapshot.data!;
          final screenshots = [
            movie["large_screenshot_image1"],
            movie["large_screenshot_image2"],
            movie["large_screenshot_image3"],
          ].where((e) => e != null).toList();

          final castList = (movie["cast"] ?? []) as List<dynamic>;
          final genres = (movie["genres"] ?? []) as List<dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== Poster + Overlay ======
                Stack(
                  children: [
                    Image.network(
                      movie["background_image_original"] ??
                          movie["large_cover_image"] ??
                          "",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 500, color: Colors.grey[800]),
                    ),
                    Container(
                      width: double.infinity,
                      height: 500,
                      color: ColorManager.primaryColor.withOpacity(0.5),
                    ),
                    Positioned(
                      bottom: 240,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // هنا ممكن تفتح Trailer باليوتيوب
                        },
                        child: SvgPicture.asset(
                          "assets/svg/buttonY.svg",
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            movie["title"] ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "${movie["year"] ?? ""}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorManager.darkGreyColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // ====== Details Section ======
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Watch button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: ColorManager.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Watch",
                            style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Ratings Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RatingWidget(
                            text: "${movie["like_count"] ?? 0}",
                            picture: "assets/svg/love_icon.svg",
                          ),
                          RatingWidget(
                            text: "${movie["runtime"] ?? 0} min",
                            picture: "assets/svg/time_icon.svg",
                          ),
                          RatingWidget(
                            text: "${movie["rating"] ?? 0.0}",
                            picture: "assets/svg/star_icon.svg",
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Screenshots
                      Text(
                        "Screen Shots",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ScreenShotWidget(
                          pic: screenshots[index],
                        ),
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                        itemCount: screenshots.length,
                      ),
                      const SizedBox(height: 16),

                      // Summary
                      Text(
                        "Summary",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie["description_full"] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Cast
                      Text(
                        "Cast",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final cast = castList[index];
                          return CastWidget(
                            pic: cast["url_small_image"] ??
                                "https://via.placeholder.com/150",
                            name: cast["name"] ?? "",
                            character: cast["character_name"] ?? "",
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                        itemCount: castList.length,
                      ),
                      const SizedBox(height: 16),

                      // Genres
                      Text(
                        "Genres",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GridView.builder(
                        itemCount: genres.length,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) =>
                            GenresWidget(text: genres[index]),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

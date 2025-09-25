import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        actionsPadding: EdgeInsets.symmetric(horizontal: 15.w),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28.sp),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [SvgPicture.asset("assets/svg/save.svg", width: 24.w, height: 24.h)],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: ApiManager.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 40.w,
                height: 40.h,
                child: CircularProgressIndicator(color: Colors.red),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                "No details found",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
                Stack(
                  children: [
                    Image.network(
                      movie["background_image_original"] ??
                          movie["large_cover_image"] ??
                          "",
                      width: double.infinity,
                      height: 500.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 500.h, color: Colors.grey[800]),
                    ),
                    Container(
                      width: double.infinity,
                      height: 500.h,
                      color: ColorManager.primaryColor.withOpacity(0.5),
                    ),
                    Positioned(
                      bottom: 240.h,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/svg/buttonY.svg",
                          width: 60.w,
                          height: 60.h,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            movie["title"] ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "${movie["year"] ?? ""}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorManager.darkGreyColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            backgroundColor: ColorManager.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Watch",
                            style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 16.h),
                      Text(
                        "Screen Shots",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            ScreenShotWidget(pic: screenshots[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: screenshots.length,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Summary",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        movie["description_full"] ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Cast",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24.sp,
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
                            SizedBox(height: 10.h),
                        itemCount: castList.length,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Genres",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      GridView.builder(
                        itemCount: genres.length,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 15.w,
                        ),
                        itemBuilder: (context, index) =>
                            GenresWidget(text: genres[index]),
                      ),
                      SizedBox(height: 40.h),
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

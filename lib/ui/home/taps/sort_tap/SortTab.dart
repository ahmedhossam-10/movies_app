import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../../../../core/remote/network/ApiManager.dart';
import '../../../movie_details/screen/movie_details_screen.dart';

class SortTab extends StatelessWidget {
  static const String routeName = 'sort';
  const SortTab({super.key});

  final List<String> categories = const [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Drama",
    "Horror",
    "Sci-Fi",
    "Romance"
  ];

  Widget buildMovieCard(BuildContext context, Map<String, dynamic> movie) {
    final int movieId = movie["id"] ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieDetailsScreen.routeName,
          arguments: movieId,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                movie["medium_cover_image"] ?? "",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey,
                  child: Icon(Icons.broken_image,
                      color: Colors.white, size: 30.sp),
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "⭐ ${movie["rating"] ?? "N/A"}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / 3 - 16;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: const Color(0xFF121312),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                physics: const BouncingScrollPhysics(),
                backgroundColor: Colors.yellow,
                borderColor: Colors.yellow,
                unselectedBackgroundColor: Colors.black,
                unselectedBorderColor: Colors.yellow,
                borderWidth: 2.w,
                radius: 16.r,
                buttonMargin: EdgeInsets.symmetric(horizontal: 6.w),
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: Colors.yellow,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: tabWidth / 4,
                ),
                tabs: categories.map((c) => Tab(text: c)).toList(),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: TabBarView(
                  children: categories.map((category) {
                    return FutureBuilder<List<dynamic>>(
                      future: ApiManager.getAllMoviesByGenre(category),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator(
                                color: Colors.yellow,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No movies found",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                          );
                        } else {
                          final movies = snapshot.data!;
                          return Padding(
                            padding: EdgeInsets.all(8.w),
                            child: GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 0.65,
                              ),
                              itemBuilder: (context, index) {
                                return buildMovieCard(
                                    context, movies[index]);
                              },
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

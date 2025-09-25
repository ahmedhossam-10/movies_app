import 'package:flutter/material.dart';
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
        print("SortTab clicked movie ID: $movieId");
        Navigator.pushNamed(
          context,
          MovieDetailsScreen.routeName,
          arguments: movieId,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                movie["medium_cover_image"] ?? "",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "⭐ ${movie["rating"] ?? "N/A"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                borderWidth: 2,
                radius: 16,
                buttonMargin: const EdgeInsets.symmetric(horizontal: 6),
                labelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.yellow,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: tabWidth / 4,
                ),
                tabs: categories.map((c) => Tab(text: c)).toList(),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: TabBarView(
                  children: categories.map((category) {
                    return FutureBuilder<List<dynamic>>(
                      future: ApiManager.getAllMoviesByGenre(category),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              "No movies found",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          final movies = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
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

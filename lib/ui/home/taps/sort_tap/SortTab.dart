import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

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

  final List<Map<String, dynamic>> movies = const [
    {
      "title": "Black Widow",
      "poster":
      "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
      "rating": 7.7
    },
    {
      "title": "Joker",
      "poster":
      "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
      "rating": 8.4
    },
    {
      "title": "Iron Man 3",
      "poster":
      "https://image.tmdb.org/t/p/w500/qhPtAc1TKbMPqNvcdXSOn9Bn7hZ.jpg",
      "rating": 7.1
    },
    {
      "title": "Civil War",
      "poster":
      "https://image.tmdb.org/t/p/w500/rAGiXaUfPzY7CDEyNKUofk3Kw2e.jpg",
      "rating": 7.8
    },
    {
      "title": "Doctor Strange",
      "poster":
      "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg",
      "rating": 7.6
    },
  ];

  Widget buildMovieCard(Map<String, dynamic> movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movie["poster"],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "⭐ ${movie["rating"]}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / 3 - 16;

    return DefaultTabController(
      length: categories.length,
      child: SafeArea(
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
            SizedBox(height: 25,),
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
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
                        return buildMovieCard(movies[index]);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

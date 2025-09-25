import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/remote/network/ApiManager.dart';

class GenreMoviesScreen extends StatefulWidget {
  final String genre;

  const GenreMoviesScreen({super.key, required this.genre});

  @override
  State<GenreMoviesScreen> createState() => _GenreMoviesScreenState();
}

class _GenreMoviesScreenState extends State<GenreMoviesScreen> {
  late Future<List<dynamic>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiManager.getAllMoviesByGenre(widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        title: Text(
          "${widget.genre} Movies",
          style: TextStyle(fontSize: 18.sp),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.yellow));
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: Image.network(
                    movie["medium_cover_image"],
                    fit: BoxFit.cover,
                    width: 50.w,
                  ),
                  title: Text(
                    movie["title"],
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    "Rating: ${movie["rating"]}",
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Text(
                  "No movies found",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ));
          }
        },
      ),
    );
  }
}

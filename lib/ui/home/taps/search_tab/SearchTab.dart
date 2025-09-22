import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/reusable_components/SearchField.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import '../../../../core/remote/network/ApiManager.dart';
import '../../../../core/reusable_components/MovieCard.dart';

class SearchTab extends StatefulWidget {
  static const String routeName = 'search';
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController controller = TextEditingController();
  List movies = [];
  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() => movies = []);
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await ApiManager.searchMovies(query);
      setState(() {
        movies = result;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchField(
                controller: controller,
                onChanged: (value) => searchMovies(value),
              ),
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (movies.isEmpty)
              Expanded(child: Image.asset(AssetsManager.empty))
            else
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(
                      imageUrl: movie["medium_cover_image"],
                      rating: (movie["rating"] as num).toDouble(),
                    );
                  },
                )

              ),
          ],
        ),
      ),
    );
  }
}

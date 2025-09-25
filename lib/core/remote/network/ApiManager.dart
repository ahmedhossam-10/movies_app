import 'package:dio/dio.dart';

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://yts.mx/api/v2",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  /// 🔍 Search movies by query
  static Future<List<dynamic>> searchMovies(String query) async {
    try {
      final response = await dio.get(
        "/list_movies.json",
        queryParameters: {
          "query_term": query,
          "limit": 20,
          "page": 1,
        },
      );

      if (response.data["status"] == "ok") {
        return response.data["data"]["movies"] ?? [];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

  /// 🎭 Get movies by genre with a limit of 10
  static Future<List<dynamic>> getMoviesByGenreAndLimit(String genre) async {
    try {
      final response = await dio.get(
        "/list_movies.json",
        queryParameters: {
          "genre": genre,
          "limit": 10,
          "page": 1,
        },
      );

      if (response.data["status"] == "ok") {
        return response.data["data"]["movies"] ?? [];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

  /// 🎥 Get all movies by genre (limit 50)
  static Future<List<dynamic>> getAllMoviesByGenre(String genre) async {
    try {
      final response = await dio.get(
        "/list_movies.json",
        queryParameters: {
          "genre": genre,
          "limit": 50,
          "page": 1,
        },
      );

      if (response.data["status"] == "ok") {
        return response.data["data"]["movies"] ?? [];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

  /// 📄 Get movie details by ID (with images + cast)
  static Future<Map<String, dynamic>?> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get(
        "/movie_details.json",
        queryParameters: {
          "movie_id": movieId,
          "with_images": true,
          "with_cast": true,
        },
      );

      if (response.data["status"] == "ok") {
        return response.data["data"]["movie"];
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}

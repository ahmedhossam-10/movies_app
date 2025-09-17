import 'package:dio/dio.dart';

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://yts.mx/api/v2",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  /// Search Movies
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
}

import 'package:dio/dio.dart';

class FavService {
  Dio dio = Dio();

  Future<void> addToFav(
      String id,
      String name,
      String image,
      double rating,
      String year,
      String token,
      ) async {
    try {
      final response = await dio.post(
        "https://route-movie-apis.vercel.app/favorites/add",
        data: {
          "movieId": id,
          "name": name,
          "rating": rating.toDouble(),
          "imageURL": image,
          "year": year,
        },
        options: Options(headers: {"AUTHORIZATION": "Bearer $token"}),
      );

      print("Added: ${response.data['message']}");
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }

  Future<void> remove(String id, String token) async {
    try {
      final response = await dio.delete(
        "https://route-movie-apis.vercel.app/favorites/remove/$id",
        options: Options(headers: {"AUTHORIZATION": "Bearer $token"}),
      );
      print("Removed: ${response.data['message']}");
    } catch (e) {
      print("Error removing movie: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAll(String token) async {
    try {
      final response = await dio.get(
        "https://route-movie-apis.vercel.app/favorites/all",
        options: Options(headers: {"AUTHORIZATION": "Bearer $token"}),
      );

      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      print("Error fetching favorites: $e");
      return [];
    }
  }

  Future<bool> isFav(String id, String token) async {
    try {
      final response = await dio.get(
        "https://route-movie-apis.vercel.app/favorites/is-favorite/$id",
        options: Options(headers: {"AUTHORIZATION": "Bearer $token"}),
      );
      return response.data['data'] ?? false;
    } catch (e) {
      print("Error checking favorite: $e");
      return false;
    }
  }
}

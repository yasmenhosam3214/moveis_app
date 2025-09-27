import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moveis_app/data/models/movie_model.dart';

class GetMovieGenre {
  Future<List<MovieModel>> getMovieByGenre(String selectedGenre) async {
    final response = await http.get(
      Uri.parse("https://yts.mx/api/v2/list_movies.json?genre=$selectedGenre"),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      final moviesJson = decoded['data']['movies'] as List<dynamic>?;


      if (moviesJson != null) {
        return moviesJson.map((movie) => MovieModel.fromJson(movie)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch movies: ${response.statusCode}');
    }
  }
}

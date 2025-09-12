import 'movie_model.dart';

class ListMoviesResponse {
  final List<MovieModel> movies;

  ListMoviesResponse({required this.movies});

  factory ListMoviesResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    final List moviesJson = data["movies"] ?? [];
    return ListMoviesResponse(
      movies: moviesJson.map((m) => MovieModel.fromJson(m)).toList(),
    );
  }
}

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final detailsUrl = Uri.parse(
          "https://yts.mx/api/v2/movie_details.json?movie_id=${event.movieId}",
        );

        final detailsResponse = await http.get(detailsUrl);

        if (detailsResponse.statusCode == 200) {
          final data = json.decode(detailsResponse.body);

          if (data["status"] == "ok" && data["data"]?["movie"] != null) {
            final movie = data["data"]["movie"];

            final similarUrl = Uri.parse(
              "https://yts.mx/api/v2/movie_suggestions.json?movie_id=${event.movieId}",
            );
            final similarResponse = await http.get(similarUrl);
            List similarMovies = [];

            if (similarResponse.statusCode == 200) {
              final similarData = json.decode(similarResponse.body);
              if (similarData["status"] == "ok") {
                similarMovies = (similarData["data"]["movies"] as List?) ?? [];
              }
            }

            final movieData = {
              "id": movie["id"],
              "title": movie["title"] ?? "",
              "year": movie["year"]?.toString() ?? "",
              "runtime": movie["runtime"]?.toString() ?? "0",
              "genres": (movie["genres"] as List?)?.cast<String>() ?? [],
              "summary": movie["description_full"] ?? "",
              "image": movie["large_cover_image"] ?? "",
              "background": movie["background_image"] ?? "",
              "trailer": movie["yt_trailer_code"] ?? "",
              "like_count": movie["like_count"]?.toString() ?? "0",
              "torrents": movie["torrents"] ?? [],
              "cast": movie["cast"] ?? [],
              "similar": similarMovies,
              "time": movie["runtime"] ?? 0,
              "rate": movie["rating"] ?? 0.0,
            };

            emit(MovieDetailLoaded(movieData: movieData));
          } else {
            emit(MovieDetailError("Movie details not found"));
          }
        } else {
          emit(
            MovieDetailError(
              "Failed to load movie details (Code: ${detailsResponse.statusCode})",
            ),
          );
        }
      } catch (e) {
        emit(MovieDetailError("Error: ${e.toString()}"));
      }
    });
  }
}

import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import 'list_movies_response.dart';

class MoviesRemoteDataSource {
  final Dio dio;

  MoviesRemoteDataSource(this.dio);

  Future<ListMoviesResponse> listMovies({
    int page = 1,
    int limit = 20,
    String? genre,
    String? queryTerm,
  }) async {
    final response = await dio.get(
      "list_movies.json",
      queryParameters: {
        "page": page,
        "limit": limit,
        if (genre != null) "genre": genre,
        if (queryTerm != null) "query_term": queryTerm,
      },
    );
    return ListMoviesResponse.fromJson(response.data);
  }
}

import 'package:moveis_app/data/models/movies_remote_data_source.dart';

import '../models/movie_model.dart';

abstract class MoviesRepository {
  Future<List<MovieModel>> getMovies({
    int page,
    String? genre,
    String? queryTerm,
  });
}

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remote;

  MoviesRepositoryImpl(this.remote);

  @override
  Future<List<MovieModel>> getMovies({
    int page = 1,
    String? genre,
    String? queryTerm,
  }) async {
    final response = await remote.listMovies(
      page: page,
      genre: genre,
      queryTerm: queryTerm,
    );
    return response.movies;
  }
}

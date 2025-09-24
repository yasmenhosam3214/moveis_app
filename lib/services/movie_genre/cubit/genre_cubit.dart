import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/data/models/movie_model.dart';
import 'package:moveis_app/services/movie_genre/api/get_movie_genre.dart';

class GenreCubit extends Cubit<GenreSate> {
  final GetMovieGenre getMovieGenre;

  GenreCubit({required this.getMovieGenre}) : super(GenreSateInitial());

  Future<void> getMoviewGenre(String genre) async {
    try {
      emit(GenreSateLoading());
      final movies = await getMovieGenre.getMovieByGenre(genre);
      emit(GenreSateLoaded(movies: movies));
    } catch (e) {
      emit(GenreSateError(msg: e.toString()));
    }
  }
}

abstract class GenreSate {}

class GenreSateInitial extends GenreSate {}

class GenreSateLoading extends GenreSate {}

class GenreSateLoaded extends GenreSate {
  final List<MovieModel> movies;

  GenreSateLoaded({required this.movies});
}

class GenreSateError extends GenreSate {
  final String msg;

  GenreSateError({required this.msg});
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'movies_event.dart';
import 'movies_state.dart';
import '../../data/repositories/movies_repository_impl.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository repository;

  MoviesBloc(this.repository) : super(const MoviesState()) {
    on<MoviesStarted>(_onStarted);
    on<MoviesLoadMore>(_onLoadMore);
    on<MoviesRefresh>(_onRefresh);
  }

  Future<void> _onStarted(
    MoviesStarted event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copyWith(status: MoviesStatus.loading, page: 1, movies: []));
    try {
      final movies = await repository.getMovies(page: 1);

      emit(
        state.copyWith(status: MoviesStatus.success, movies: movies, page: 1),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MoviesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    MoviesLoadMore event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.hasReachedEnd || state.status == MoviesStatus.loading) return;

    try {
      final nextPage = state.page + 1;
      final movies = await repository.getMovies(page: nextPage);
      if (movies.isEmpty) {
        emit(state.copyWith(hasReachedEnd: true));
      } else {
        emit(
          state.copyWith(
            movies: List.of(state.movies)..addAll(movies),
            page: nextPage,
            status: MoviesStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: MoviesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefresh(
    MoviesRefresh event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      final movies = await repository.getMovies(page: 1);
      emit(
        state.copyWith(
          status: MoviesStatus.success,
          movies: movies,
          page: 1,
          hasReachedEnd: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MoviesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }



}

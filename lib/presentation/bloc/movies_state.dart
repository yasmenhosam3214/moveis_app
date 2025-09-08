import 'package:equatable/equatable.dart';
import '../../data/models/movie_model.dart';

enum MoviesStatus { initial, loading, success, failure }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<MovieModel> movies;
  final bool hasReachedEnd;
  final int page;
  final String? errorMessage;

  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const [],
    this.hasReachedEnd = false,
    this.page = 1,
    this.errorMessage,
  });

  MoviesState copyWith({
    MoviesStatus? status,
    List<MovieModel>? movies,
    bool? hasReachedEnd,
    int? page,
    String? errorMessage,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    movies,
    hasReachedEnd,
    page,
    errorMessage,
  ];
}

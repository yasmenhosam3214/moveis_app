abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Map<String, dynamic> movieData;
  MovieDetailLoaded({required this.movieData});
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
}

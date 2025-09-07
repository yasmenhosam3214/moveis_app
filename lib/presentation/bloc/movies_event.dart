import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class MoviesStarted extends MoviesEvent {
  const MoviesStarted();
}

class MoviesLoadMore extends MoviesEvent {
  const MoviesLoadMore();
}

class MoviesRefresh extends MoviesEvent {
  const MoviesRefresh();
}

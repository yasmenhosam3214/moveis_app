import 'package:bloc/bloc.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        // يمكن هنا ربط API
        await Future.delayed(const Duration(seconds: 1));
        final dummyData = {
          "title": "Doctor Strange in the Multiverse of Madness",
          "year": "2022",
          "cast": [
            {
              "name": "Hayley Atwell",
              "role": "Captain Carter",
              "img": "assets/images/Rectangle 22.png",
              "rating": "8.5",
            },
            {
              "name": "Elizabeth Olsen",
              "role": "Wanda Maximoff",
              "img": "assets/images/Elizabeth Olsen.png",
              "rating": "9.0",
            },
            {
              "name": "Rachel McAdams",
              "role": "Dr. Christine Palmer",
              "img": "assets/images/Rachel McAdams.png",
              "rating": "7.8",
            },
            {
              "name": "Charlize Theron",
              "role": "Clea",
              "img": "assets/images/Charlize Theron.png",
              "rating": "8.2",
            },
          ],
          "similar": [
            {"img": "assets/images/Similar 1.png", "rating": "7.6"},
            {"img": "assets/images/Similar 2.png", "rating": "8.2"},
            {"img": "assets/images/Similar 3.png", "rating": "7.9"},
            {"img": "assets/images/Similar 4.png", "rating": "8.0"},
          ],
        };
        emit(MovieDetailLoaded(movieData: dummyData));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });
  }
}

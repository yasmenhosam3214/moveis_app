import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/services/fav_service/fav_services.dart';

abstract class FavCubitState {}

class FavCubitStateInitial extends FavCubitState {}

class FavCubitStateLoading extends FavCubitState {}

class FavCubitStateLoaded extends FavCubitState {
  final bool isFav;
  FavCubitStateLoaded({required this.isFav});
}

class FavCubitStateError extends FavCubitState {
  final String error;
  FavCubitStateError({required this.error});
}

class FavCubitStateAll extends FavCubitState {
  final List<Map<String, dynamic>> favorites;
  FavCubitStateAll({required this.favorites});
}

class FavCubit extends Cubit<FavCubitState> {
  final FavService favService;
  bool _isFav = false; // keep local state

  FavCubit(this.favService) : super(FavCubitStateInitial());

  Future<void> addToFav(
      String id,
      String name,
      String image,
      double rating,
      String year,
      String token,
      ) async {
    emit(FavCubitStateLoading());
    try {
      await favService.addToFav(id, name, image, rating, year, token);
      _isFav = true;
      emit(FavCubitStateLoaded(isFav: _isFav));
    } catch (e) {
      emit(FavCubitStateError(error: e.toString()));
    }
  }

  Future<void> removeFromFav(String id, String token) async {
    emit(FavCubitStateLoading());
    try {
      await favService.remove(id, token);
      _isFav = false;
      emit(FavCubitStateLoaded(isFav: _isFav));
    } catch (e) {
      emit(FavCubitStateError(error: e.toString()));
    }
  }

  Future<void> isFav(String id, String token) async {
    emit(FavCubitStateLoading());
    try {
      final response = await favService.isFav(id, token);
      _isFav = response;
      emit(FavCubitStateLoaded(isFav: _isFav));
    } catch (e) {
      emit(FavCubitStateError(error: e.toString()));
    }
  }

  Future<void> getAllFavs(String token) async {
    emit(FavCubitStateLoading());
    try {
      final favorites = await favService.getAll(token);
      emit(FavCubitStateAll(favorites: favorites));
    } catch (e) {
      emit(FavCubitStateError(error: e.toString()));
    }
  }
}

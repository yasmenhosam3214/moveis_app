import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class MovieModel {
  final String title;
  final int year;
  final String image;

  MovieModel({required this.title, required this.year, required this.image});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? 'No Title',
      year: json['year'] ?? 0, image: '',

    );
  }
}


class SearchMethod {
  Future<List<MovieModel>> fetchUsers(String movieTitle) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://yts.mx/api/v2/list_movies.json?query_term=$movieTitle"),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final moviesJson = decoded['data']['movies'] as List<dynamic>?;

        if (moviesJson != null) {
          return moviesJson
              .map((movie) => MovieModel.fromJson(movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to fetch movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}


abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MovieModel> movies;
  SearchLoaded(this.movies);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}


class SearchCubit extends Cubit<SearchState> {
  final SearchMethod searchMethod;

  SearchCubit(this.searchMethod) : super(SearchInitial());

  Future<void> fetchUsers(String movieTitle) async {
    emit(SearchLoading());
    try {
      final movies = await searchMethod.fetchUsers(movieTitle);
      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
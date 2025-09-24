import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

//
// Movie Model
//
class MovieModel {
  final String title;
  final int year;
  final String image;
  final double rating;

  MovieModel({
    required this.title,
    required this.year,
    required this.image,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? 'No Title',
      year: json['year'] ?? 0,
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}

//
// Repository / API Method
//
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

//
// States
//
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

//
// Cubit
//
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

//
// UI
//
class SearchTab extends StatelessWidget {
  static  String routeName = "/search";

  final TextEditingController _controller = TextEditingController();

  SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(SearchMethod()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    // Search Box
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        style:  TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon:  Icon(Icons.search,
                                color: Colors.white54),
                            onPressed: () {
                              final query = _controller.text.trim();
                              if (query.isNotEmpty) {
                                context.read<SearchCubit>().fetchUsers(query);
                              }
                            },
                          ),
                          hintText: 'Search',
                          hintStyle:  TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (query) {
                          if (query.isNotEmpty) {
                            context.read<SearchCubit>().fetchUsers(query);
                          }
                        },
                      ),
                    ),
                     SizedBox(height: 20),

                    // Movies Grid
                    Expanded(
                      child: BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchInitial) {
                            return Center(
                              child: Image.asset(
                                "assets/images/logosearch.png",
                                width: 124,
                                height: 124,
                              ),
                            );
                          } else if (state is SearchLoading) {
                            return  Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SearchLoaded) {
                            if (state.movies.isEmpty) {
                              return Center(
                                child: Text("No movies found",
                                    style: TextStyle(color: Colors.white)),
                              );
                            }

                            return GridView.builder(
                              padding:  EdgeInsets.all(8),
                              itemCount: state.movies.length,
                              gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 2 / 3,
                              ),
                              itemBuilder: (context, index) {
                                final movie = state.movies[index];
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        movie.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      left: 6,
                                      child: Container(
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                             Icon(Icons.star,
                                                color: Colors.amber, size: 14),
                                              SizedBox(width: 2),
                                            Text(
                                              movie.rating.toString(),
                                              style:  TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (state is SearchError) {
                            return Center(
                              child: Text(state.message,
                                  style:  TextStyle(color: Colors.red)),
                            );
                          }
                          return  SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

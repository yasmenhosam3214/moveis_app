import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/data/models/movie_model.dart';
import 'package:moveis_app/presentation/bloc/movies_bloc.dart';
import 'package:moveis_app/presentation/bloc/movies_state.dart';
import 'package:moveis_app/services/movie_genre/cubit/genre_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrowseScreen extends StatefulWidget {
  static const String routeName = "/browse";

  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String? selectedCategory;
  List<String> categories = [];
  List<MovieModel> movies = [];

  @override
  void initState() {
    super.initState();
    _loadCategoriesFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.status == MoviesStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MoviesStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage ?? "Error",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final movies = state.movies;
        if (movies.isEmpty) {
          return const Center(
            child: Text(
              "No Movies Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        // ✅ Save genres once when movies load
        if (categories.isEmpty) {
          _saveGenresFromMovies(movies);
        }

        this.movies = movies;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategories(),
                const SizedBox(height: 12),

                BlocBuilder<GenreCubit, GenreSate>(
                  builder: (context, genreState) {
                    if (genreState is GenreSateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (genreState is GenreSateError) {
                      return Center(
                        child: Text(
                          genreState.msg,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (genreState is GenreSateLoaded) {
                      if (genreState.movies.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Movies in this Genre",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      // show genre filtered movies
                      return _buildMovieGrid(genreState.movies);
                    }

                    // default fallback → show all movies from MoviesBloc
                    if (movies.isNotEmpty) {
                      return _buildMovieGrid(movies);
                    }

                    return const Center(
                      child: Text(
                        "No Movies Found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ====================== UI ======================

  Widget _buildCategories() {
    if (categories.isEmpty) {
      return const SizedBox(height: 40); // placeholder space
    }

    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 6),
          itemBuilder: (context, index) {
            final cat = categories[index];
            final selected = selectedCategory == cat;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = cat;
                  onSelectCategory(cat);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFF6BD00)
                      : const Color(0xFF121312),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF6BD00), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  cat,
                  style: TextStyle(
                    color: selected ? Colors.black : const Color(0xFFF6BD00),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMovieGrid(List<MovieModel> movieList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          for (int i = 0; i < movieList.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(child: _buildMovieItem(movieList[i])),
                  const SizedBox(width: 12),
                  if (i + 1 < movieList.length)
                    Expanded(child: _buildMovieItem(movieList[i + 1])),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMovieItem(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/MovieDetailScreen", arguments: movie.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              movie.largeCoverImage,
              fit: BoxFit.cover,
              height: 279,
              width: 189,
            ),
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF282A28).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFF6BD00), size: 14),
                    const SizedBox(width: 3),
                    Text(
                      movie.rating.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ====================== Helpers ======================

  Future<void> _saveGenresFromMovies(List<MovieModel> movies) async {
    final Set<String> genres = {};
    for (var movie in movies) {
      genres.addAll(movie.genres ?? []);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("all_genres", genres.toList());

    setState(() {
      categories = genres.toList();
      selectedCategory = categories.first;
    });

    onSelectCategory(selectedCategory);
  }

  Future<void> _loadCategoriesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList("all_genres");

    if (saved != null && saved.isNotEmpty) {
      setState(() {
        categories = saved;
        selectedCategory = categories.first;
      });
      onSelectCategory(selectedCategory);
    }
  }

  void onSelectCategory(String? selectedCategory) {
    if (selectedCategory != null) {
      context.read<GenreCubit>().getMoviewGenre(selectedCategory);
    }
  }
}

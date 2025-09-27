import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';
import 'package:moveis_app/presentation/bloc/movie_detail_bloc.dart';
import 'package:moveis_app/presentation/bloc/movie_detail_event.dart';
import 'package:moveis_app/presentation/bloc/movie_detail_state.dart';
import 'package:moveis_app/presentation/widgets/default_elevatedButton.dart';
import 'package:moveis_app/presentation/widgets/poster_widget.dart';
import 'package:moveis_app/screens/details/build_bottom_stat.dart';
import 'package:moveis_app/services/fav_service/fav_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/MovieDetailScreen';

  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  String? token;
  late int movieID;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final shared = await SharedPreferences.getInstance();
    setState(() => token = shared.getString("user_token"));
  }

  @override
  Widget build(BuildContext context) {
    movieID = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (_) => MovieDetailBloc()..add(LoadMovieDetail(movieID)),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieDetailLoaded) {
                final movie = state.movieData;

                // Save last watched movie
                _saveMovieDetails(movie);

                if (token != null) {
                  context.read<FavCubit>().isFav(movieID.toString(), token!);
                }

                return _MovieDetailContent(
                  movie: movie,
                  movieID: movieID,
                  token: token,
                );
              } else if (state is MovieDetailError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _saveMovieDetails(Map<String, dynamic> movie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "last_watched_movie",
      jsonEncode(movie), // safe for nested maps/lists
    );
    debugPrint("Saved last watched movie: ${movie['title']}");
  }
}

class _MovieDetailContent extends StatelessWidget {
  final Map<String, dynamic> movie;
  final int movieID;
  final String? token;

  const _MovieDetailContent({
    required this.movie,
    required this.movieID,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topHeight = screenHeight * 0.65;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                movie["image"] ?? "https://via.placeholder.com/300x450",
                height: topHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                left: 16,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset('assets/icons/arrow.png'),
                ),
              ),
              Positioned(
                top: 12,
                right: 16,
                child: _BookmarkButton(
                  movie: movie,
                  movieID: movieID,
                  token: token,
                ),
              ),
              Positioned(
                top: topHeight * 0.82,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Text(
                      movie["title"] ?? "Unknown",
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie["year"] ?? "",
                      style: textTheme.titleLarge?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _BottomContent(movie: movie, screenWidth: screenWidth),
        ],
      ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  final Map<String, dynamic> movie;
  final int movieID;
  final String? token;

  const _BookmarkButton({
    required this.movie,
    required this.movieID,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavCubitState>(
      builder: (context, state) {
        bool isFav = false;
        if (state is FavCubitStateLoaded) {
          isFav = state.isFav;
        }

        return IconButton(
          onPressed: () {
            if (token == null) return;
            if (isFav) {
              context.read<FavCubit>().removeFromFav(
                movieID.toString(),
                token!,
              );
            } else {
              context.read<FavCubit>().addToFav(
                movieID.toString(),
                movie['title'],
                movie['image'],
                (movie['rate'] as num).toDouble(),
                movie['year'],
                token!,
              );
            }
          },
          icon: Icon(
            isFav ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class _BottomContent extends StatelessWidget {
  final Map<String, dynamic> movie;
  final double screenWidth;

  const _BottomContent({required this.movie, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: DefaultElevatedbutton(
                onPressed: () {},
                text: "Watch",
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.red,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBottomStat(Icons.favorite, movie['like_count']),
                buildBottomStat(Icons.timelapse_sharp, "${movie['time']}"),
                buildBottomStat(Icons.star, "${movie["rate"]}"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Similar"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movie["similar"].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 600 ? 2 : 4,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = movie["similar"][index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailScreen.routeName,
                      arguments: item['id'],
                    );
                  },
                  child: PosterWidget(
                    imgPath: item["medium_cover_image"] ?? "",
                    rating: item["rating"].toString(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Summary"),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              movie["summary"] ?? "No description available.",
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
          if ((movie["genres"] as List).isNotEmpty) ...[
            _buildSectionTitle("Genres"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 10,
                children: (movie["genres"] as List)
                    .map<Widget>((g) => _buildChip(g))
                    .toList(),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      side: BorderSide.none,
      backgroundColor: AppColors.black,
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

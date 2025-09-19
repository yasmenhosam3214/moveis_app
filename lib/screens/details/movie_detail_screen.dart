import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';
import 'package:moveis_app/presentation/bloc/movie_detail_bloc.dart';
import 'package:moveis_app/presentation/bloc/movie_detail_event.dart';
import 'package:moveis_app/presentation/bloc/movie_detail_state.dart';
import 'package:moveis_app/presentation/widgets/cast_card.dart';
import 'package:moveis_app/presentation/widgets/default_elevatedButton.dart';
import 'package:moveis_app/presentation/widgets/poster_widget.dart';
import 'package:moveis_app/screens/details/build_bottom_stat.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String routeName = '/MovieDetailScreen';

  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieID = ModalRoute.of(context)!.settings.arguments as int;
    print(movieID);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topHeight = screenHeight * 0.65;
    TextTheme textTheme = Theme.of(context).textTheme;

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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: topHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  movie["image"] ??
                                      "https://via.placeholder.com/300x450",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/icons/bookmark_border.png',
                              ),
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

                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // 🔹 Watch Button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: SizedBox(
                                width: double.infinity,
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

                            // 🔹 Bottom Stats
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: buildBottomStat(
                                      Icons.favorite,
                                      movie['like_count'],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: buildBottomStat(
                                      Icons.timelapse_sharp,
                                      "${movie['time']}",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: buildBottomStat(
                                      Icons.star,
                                      "${movie["rate"]}" ?? "N/A",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildSectionTitle("Similar"),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: movie["similar"].length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                                        "/MovieDetailScreen",
                                        arguments: item['id'],
                                      );
                                    },
                                    child: PosterWidget(
                                      imgPath: item["medium_cover_image"],
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

                            // if ((movie["cast"] as List).isNotEmpty) ...[
                            //   _buildSectionTitle("Cast"),
                            //   Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 12,
                            //     ),
                            //     child: Column(
                            //       children: (movie["cast"] as List)
                            //           .map<Widget>(
                            //             (cast) => CastCard(
                            //               name: cast["name"] ?? "",
                            //               role: cast["character_name"] ?? "",
                            //               img:
                            //                   cast["url_small_image"] ??
                            //                   "https://via.placeholder.com/100",
                            //               rating: movie["rating"] ?? "N/A",
                            //             ),
                            //           )
                            //           .toList(),
                            //     ),
                            //   ),
                            //   const SizedBox(height: 20),
                            // ],
                            if ((movie["genres"] as List).isNotEmpty) ...[
                              _buildSectionTitle("Genres"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
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
                      ),
                    ],
                  ),
                );
              } else if (state is MovieDetailError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        side: const BorderSide(width: 0),
        backgroundColor: AppColors.black,
        label: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

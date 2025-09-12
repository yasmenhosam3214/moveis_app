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
  final int movieId;
  static const String routeName = '/MovieDetailScreen';

  const MovieDetailScreen({super.key, this.movieId = 0});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topHeight = screenHeight * 0.65;
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => MovieDetailBloc()..add(LoadMovieDetail(movieId)),
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/DoctorStrange.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 16,
                            child: IconButton(
                              onPressed: () {},
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
                            top: topHeight * 0.4,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/images/Iconsplay.png',
                                  width: 97,
                                  height: 97,
                                ),
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
                                  movie["title"],
                                  textAlign: TextAlign.center,
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie["year"],
                                  style: textTheme.titleLarge,
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

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildBottomStat(Icons.favorite, "15"),
                                  const SizedBox(width: 16),
                                  buildBottomStat(Icons.comment, "90"),
                                  const SizedBox(width: 16),
                                  buildBottomStat(Icons.star, "7.6"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Screen Shots
                            _buildSectionTitle("Screen Shots"),
                            Column(
                              children: [
                                _buildImage(
                                  "assets/images/large-screenshot1.png",
                                ),
                                const SizedBox(height: 12),
                                _buildImage(
                                  "assets/images/large-screenshot2.png",
                                ),
                                const SizedBox(height: 12),
                                _buildImage(
                                  "assets/images/large-screenshot3.png",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Similar Grid
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
                                  return PosterWidget(
                                    imgPath: item["img"],
                                    rating: item["rating"],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),

                            _buildSectionTitle("Summary"),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse...",
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),
                            ),

                            _buildSectionTitle("Cast"),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                children: movie["cast"]
                                    .map<Widget>(
                                      (cast) => CastCard(
                                        name: cast["name"],
                                        role: cast["role"],
                                        img: cast["img"],
                                        rating: cast["rating"],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 20),

                            _buildSectionTitle("Genres"),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Wrap(
                                spacing: 10,
                                children: [
                                  _buildChip("Action"),
                                  _buildChip("Sci-Fi"),
                                  _buildChip("Adventure"),
                                  _buildChip("Fantasy"),
                                  _buildChip("Horror"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
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

  Widget _buildImage(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Chip(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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

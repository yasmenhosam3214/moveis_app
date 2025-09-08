import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/presentation/bloc/movies_bloc.dart';
import 'package:moveis_app/presentation/bloc/movies_state.dart';
import 'package:moveis_app/presentation/widgets/movie_card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(
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

          return Stack(
            children: [
             
              Image.asset(
                "assets/images/onbording6.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/AvailableNow.png",
                        width: 267,
                        height: 93,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CarouselSlider(
                      items: movies.take(6).map((m) {
                        return MovieCard(
                          title: m.title,
                          imageUrl: m.largeCoverImage,
                          rating: m.rating,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 320,
                        enlargeCenterPage: true,
                        viewportFraction: 0.5,
                      ),
                    ),

                    Center(
                      child: Image.asset(
                        "assets/images/WatchNow.png",
                        width: 354,
                        height: 93,
                        fit: BoxFit.contain,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Action",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "See More",
                                style: TextStyle(
                                  color: Color(0xFFF6BD00),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFFF6BD00),
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final m = movies[index];
                          return MovieCard(
                            title: m.title,
                            imageUrl: m.mediumCoverImage ?? m.largeCoverImage,
                            rating: m.rating,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemCount: movies.length > 10 ? 10 : movies.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

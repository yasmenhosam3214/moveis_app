import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/core/network/dio_Client.dart';
import 'package:moveis_app/data/models/movies_remote_data_source.dart';
import 'package:moveis_app/data/repositories/movies_repository_impl.dart';
import 'package:moveis_app/presentation/bloc/movies_bloc.dart';
import 'package:moveis_app/presentation/bloc/movies_event.dart';
import 'package:moveis_app/screens/home/home_tab.dart';
import 'package:moveis_app/services/auth_service/api/auth_service.dart';
import 'package:moveis_app/services/auth_service/cubit/user_cubit.dart';
import 'package:moveis_app/services/movie_genre/api/get_movie_genre.dart';
import 'package:moveis_app/services/movie_genre/cubit/genre_cubit.dart';
import 'package:moveis_app/tabs/browse/browse_screen.dart';
import 'package:moveis_app/tabs/profile/profile_tab.dart';
import 'package:moveis_app/tabs/profile/update_profile_screen.dart';
import 'package:moveis_app/tabs/search/search_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  late final MoviesRepositoryImpl moviesRepository = MoviesRepositoryImpl(
    MoviesRemoteDataSource(DioClient.instance),
  );

  Widget buildNavIcon(String imagePath, String activePath, bool isActive) {
    return Image.asset(
      isActive ? activePath : imagePath,
      width: 26,
      height: 23,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      BlocProvider(
        create: (_) => MoviesBloc(moviesRepository)..add(const MoviesStarted()),
        child: HomeTab(),
      ),
      SearchTab(),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                MoviesBloc(moviesRepository)..add(const MoviesStarted()),
          ),
          BlocProvider(
            create: (context) => GenreCubit(getMovieGenre: GetMovieGenre()),
          ),
        ],
        child: BrowseScreen(),
      ),
      BlocProvider(
        create: (BuildContext context) {
          return AuthCubit(AuthService());
        },
        child: ProfileTab(),
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: tabs),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 9, right: 9),
        child: Container(
          height: 61,
          decoration: BoxDecoration(
            color: const Color(0xFF282A28),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setState(() => currentIndex = 0),
                child: buildNavIcon(
                  "assets/icons/Vector (home).png",
                  "assets/icons/vector (home_active).png",
                  currentIndex == 0,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => currentIndex = 1),
                child: buildNavIcon(
                  "assets/icons/Vector (search).png",
                  "assets/icons/Vector (search_active).png",
                  currentIndex == 1,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => currentIndex = 2),
                child: buildNavIcon(
                  "assets/icons/Vector(browse).png",
                  "assets/icons/Vector(browse_active).png",
                  currentIndex == 2,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => currentIndex = 3),
                child: buildNavIcon(
                  "assets/icons/Vector(Profiel).png",
                  "assets/icons/Vector(Profile_active).png",
                  currentIndex == 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

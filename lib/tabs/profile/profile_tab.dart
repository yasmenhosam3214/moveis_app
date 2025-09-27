import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service/cubit/auth_state.dart';
import '../../services/auth_service/cubit/user_cubit.dart';
import '../../services/fav_service/fav_cubit.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int image = 1;
  String username = '';

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
    loadFav();
  }

  Future<void> loadFav() async {
    final shared = await SharedPreferences.getInstance();
    final token = shared.getString("user_token");
    if (token != null) {
      context.read<FavCubit>().getAllFavs(token);
    }
  }

  Future<Map<String, dynamic>?> _getLastMovie() async {
    final prefs = await SharedPreferences.getInstance();
    final movieString = prefs.getString("last_watched_movie");
    if (movieString == null) return null;
    return Map<String, dynamic>.from(jsonDecode(movieString));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is ProfileFetched) {
          image = state.profile.avaterId ?? 1;
          username = state.profile.name;
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: Colors.black,
                onRefresh: () async {
                  context.read<AuthCubit>().getProfile();
                  await loadFav();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.yellow, Colors.red],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                'assets/images/avatar_${image}.png',
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                _ProfileStat(title: "Wish List", value: "12"),
                                _ProfileStat(title: "History", value: "1"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          username.isNotEmpty ? username : "Loading...",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/update");
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                              ),
                              child: const Text("Edit Profile"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/login",
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                              ),
                              icon: const Icon(Icons.logout),
                              label: const Text("Exit"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const TabBar(
                          indicatorColor: AppColors.primary,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
                          tabs: [
                            Tab(icon: Icon(Icons.list), text: "Watch List"),
                            Tab(icon: Icon(Icons.history), text: "History"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 500,
                        child: TabBarView(
                          children: [
                            // Watch List
                            BlocBuilder<FavCubit, FavCubitState>(
                              builder: (context, state) {
                                if (state is FavCubitStateLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else if (state is FavCubitStateAll) {
                                  final favs = state.favorites;
                                  if (favs.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        "No movies in your wishlist",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: favs.length,
                                    itemBuilder: (context, index) {
                                      final movie = favs[index];
                                      return Card(
                                        color: Colors.grey[850],
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            movie['name'] ?? 'Unknown',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Year: ${movie['year']}, Rating: ${movie['rating']}",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          leading: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              movie['imageURL'] ?? '',
                                              width: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                          trailing: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is FavCubitStateError) {
                                  return Center(
                                    child: Text(
                                      "Error: ${state.error}",
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text(
                                    "Loading favorites...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),

                            FutureBuilder<Map<String, dynamic>?>(
                              future: _getLastMovie(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const Center(
                                    child: Text(
                                      "No movies watched yet",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                final movie = snapshot.data!;
                                return ListView(
                                  padding: const EdgeInsets.all(8),
                                  children: [
                                    Card(
                                      color: Colors.grey[850],
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child:
                                              movie['image'] != null &&
                                                  movie['image'].isNotEmpty
                                              ? Image.network(
                                                  movie['image'],
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.white,
                                                      ),
                                                )
                                              : const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.white,
                                                ),
                                        ),
                                        title: Text(
                                          movie['title'] ?? 'Unknown',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Year: ${movie['year'] ?? 'N/A'}, Rating: ${movie['rate'] ?? 'N/A'}",
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 17)),
      ],
    );
  }
}

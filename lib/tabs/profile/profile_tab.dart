import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';
import '../../services/auth_service/cubit/user_cubit.dart';
import '../../services/auth_service/cubit/auth_state.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String image = '';
  String username = '';

  @override
  void initState() {
    context.read<AuthCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is ProfileFetched) {
          image = "assets/images/onbording4.png";
          username = state.profile.name;
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: SingleChildScrollView(
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
                              image.isNotEmpty
                                  ? image
                                  : 'assets/images/avatar_1.png',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              _ProfileStat(title: "Wish List", value: "12"),
                              _ProfileStat(title: "History", value: "10"),
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
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                          ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey[850],
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      "assets/images/onbording4.png",
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    "Movie $index",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: const Text(
                                    "Your favorite",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  trailing: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),

                          GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      "assets/images/onbording4.png",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 14,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "7.7",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
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

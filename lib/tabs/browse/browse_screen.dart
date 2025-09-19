import 'package:flutter/material.dart';

class BrowseScreen extends StatefulWidget {
  static const String routeName = "/browse";

  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String selectedCategory = "Action";

  final categories = [
    {"label": "Action", "width": 65.24},
    {"label": "Adventure", "width": 126.48},
    {"label": "Animation", "width": 126.48},
    {"label": "Biography", "width": 126.48},
  ];

  final movies = [
    {"image": "assets/images/black_widow.png", "rating": 7.7},
    {"image": "assets/images/joker.png", "rating": 7.7},
    {"image": "assets/images/iron man.jpg", "rating": 7.7},
    {"image": "assets/images/cavel.jpg", "rating": 7.7},
    {"image": "assets/images/categoryid.jpg", "rating": 7.7},
    {"image": "assets/images/categ6.jpg", "rating": 7.7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final selected = selectedCategory == cat["label"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat["label"] as String;
                        });
                      },
                      child: Container(
                        width: cat["width"] as double,
                        height: 16,
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFF6BD00)
                              : const Color(0xFF121312),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFF6BD00),
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cat["label"] as String,
                          style: TextStyle(
                            color: selected
                                ? Colors.black
                                : const Color(0xFFF6BD00),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  for (int i = 0; i < movies.length; i += 2)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(child: buildMovieItem(movies[i])),
                          const SizedBox(width: 12),
                          if (i + 1 < movies.length)
                            Expanded(child: buildMovieItem(movies[i + 1])),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMovieItem(Map<String, dynamic> movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.asset(
            movie["image"] as String,
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
                    movie["rating"].toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

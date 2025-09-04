import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Available Now
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Available Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 🔹 Slider للأفلام
            SizedBox(
              height: 280,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildMovieCard("assets/images/1917.jpg", "7.7"),
                  buildMovieCard("assets/images/captain.jpg", "7.7"),
                  buildMovieCard("assets/images/batman.jpg", "8.5"),
                ],
              ),
            ),

            // 🔹 Watch Now
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Watch Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 🔹 قسم Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Action",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See More →",
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ],
            ),

            // 🔹 أفلام Action
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildMovieCard("assets/images/captain.jpg", "7.7"),
                  buildMovieCard("assets/images/batman.jpg", "8.2"),
                  buildMovieCard("assets/images/blackwidow.jpg", "7.0"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget للفيلم (Card)
  Widget buildMovieCard(String imagePath, String rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, width: 160, fit: BoxFit.cover),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Text(
                  rating,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const Icon(Icons.star, color: Colors.yellow, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

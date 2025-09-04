import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTab extends StatelessWidget {
  final List<String> movies = [
    "assets/images/card1.jpg",
    "assets/images/card2.png",
    "assets/images/card3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    "assets/images/Available Now.png",
                    width: 267,
                    height: 93,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),

                CarouselSlider(
                  items: movies.map((imgPath) {
                    return _buildMovieCard(imgPath);
                  }).toList(),
                  options: CarouselOptions(
                    height: 320,
                    enlargeCenterPage: true,
                    viewportFraction: 0.5,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                  ),
                ),

                Center(
                  child: Image.asset(
                    "assets/images/Watch Now.png",
                    width: 354,
                    height: 93,
                    fit: BoxFit.contain,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Action",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildMovieCard(
                        "assets/images/photo1seemore.png",
                        small: true,
                      ),
                      const SizedBox(width: 12),
                      _buildMovieCard(
                        "assets/images/photo2seemore.png",
                        small: true,
                      ),
                      const SizedBox(width: 12),
                      _buildMovieCard(
                        "assets/images/photo3seemore.jpg",
                        small: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(String imgPath, {bool small = false}) {
    double width = small ? 120 : 200;
    double height = small ? 180 : 300;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imgPath,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 9,
          left: 9,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.star, color: Colors.yellow, size: 14),
                SizedBox(width: 3),
                Text(
                  "7.7",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final bool small;

  const MovieCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    double width = small ? 120 : 200;
    double height = small ? 180 : 300;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: width,
              height: height,
              color: Colors.grey[800],
            ),
            errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              color: Colors.grey,
              child: const Icon(Icons.broken_image, color: Colors.red),
            ),
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
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 14),
                const SizedBox(width: 3),
                Text(
                  rating.toString(),
                  style: const TextStyle(
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

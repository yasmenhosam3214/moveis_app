class MovieModel {
  final int id;
  final String title;
  final double rating;
  final String largeCoverImage;
  final String? mediumCoverImage;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.largeCoverImage,
    this.mediumCoverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"] ?? "",
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      largeCoverImage: json["large_cover_image"] ?? "",
      mediumCoverImage: json["medium_cover_image"],
    );
  }
}

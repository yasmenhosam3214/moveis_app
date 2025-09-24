import 'package:moveis_app/data/models/movie_model.dart';

class UserProfile {
  final String email;
  final String name;
  final String phone;
  final int avaterId;
  final List<MovieModel> watchList;
  final List<MovieModel> history;

  UserProfile({
    required this.email,
    required this.name,
    required this.phone,
    required this.avaterId,
    this.watchList = const [],
    this.history = const [],
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      avaterId: json["avaterId"] ?? 0,
      watchList:
          (json["watchList"] as List?)
              ?.map((m) => MovieModel.fromJson(m))
              .toList() ??
          [],
      history:
          (json["history"] as List?)
              ?.map((m) => MovieModel.fromJson(m))
              .toList() ??
          [],
    );
  }
}

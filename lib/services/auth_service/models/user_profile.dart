class UserProfile {
  final String email;
  final String name;
  final String phone;
  final int avaterId;

  UserProfile({
    required this.email,
    required this.name,
    required this.phone,
    required this.avaterId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      avaterId: json["avaterId"],
    );
  }
}

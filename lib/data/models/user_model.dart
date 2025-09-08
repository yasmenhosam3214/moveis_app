
class UserResponse {
  final String message;
  final UserModel data;

  UserResponse({required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json["message"] ?? "",
      data: UserModel.fromJson(json["data"] ?? {}),
    );
  }
}


class UserModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final int avatarId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avatarId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      avatarId: json["avaterId"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "avaterId": avatarId,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }
}


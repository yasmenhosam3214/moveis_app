import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moveis_app/services/auth_service/models/user_model.dart';

import '../../../data/models/user_model.dart';
import '../models/user_profile.dart';

class AuthService {
  final String baseUrl = "https://route-movie-apis.vercel.app";

  Future<UserResponse> register(
    String username,
    String email,
    String password,
    String confirmPassword,
    String phone,
    int avatarId,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": username,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avatarId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return UserResponse.fromJson(jsonData);
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final message = errorJson["message"];
      if (message is List) {
        throw ApiException(List<String>.from(message));
      } else if (message is String) {
        throw ApiException([message]);
      } else {
        throw ApiException(["Unknown error occurred"]);
      }
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final message = errorJson["message"];
      if (message is List) {
        throw ApiException(List<String>.from(message));
      } else if (message is String) {
        throw ApiException([message]);
      } else {
        throw ApiException(["Unknown error occurred"]);
      }
    }
  }

  Future<String> resetPassword({
    required String oldPass,
    required String newPass,
    required String token,
  }) async {
    final response = await http.patch(
      Uri.parse("$baseUrl/auth/reset-password"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"oldPassword": oldPass, "newPassword": newPass}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData["message"] ?? "Password reset request sent successfully";
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final message = errorJson["message"];
      if (message is List) {
        throw ApiException(List<String>.from(message));
      } else if (message is String) {
        throw ApiException([message]);
      } else {
        throw ApiException(["Unknown error occurred"]);
      }
    }
  }

  Future<String> updateProfile(
    String email,
    int avatarId,
    String phone,
    String name,
    String token,
  ) async {
    final response = await http.patch(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "email": email,
        "avaterId": avatarId,
        "phone": phone,
        "name": name,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData["message"] ?? "Profile updated successfully";
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final message = errorJson["message"];
      if (message is List) {
        throw ApiException(List<String>.from(message));
      } else if (message is String) {
        throw ApiException([message]);
      } else {
        throw ApiException(["Unknown error occurred"]);
      }
    }
  }

  Future<UserProfile> getProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final data = jsonData["data"];
      if (data != null) {
        return UserProfile.fromJson(data);
      } else {
        throw ApiException(["Profile data not found"]);
      }
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final message = errorJson["message"];
      if (message is List) {
        throw ApiException(List<String>.from(message));
      } else if (message is String) {
        throw ApiException([message]);
      } else {
        throw ApiException(["Unknown error occurred"]);
      }
    }
  }

  Future<String> deleteProfile(String token) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      if (response.body.isEmpty) {
        return "Deleted Successfully";
      }


      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey("message")) {
        return jsonData["message"].toString();
      }

      return "Deleted Successfully";
    }

    try {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final message = errorJson["message"] ?? errorJson["error"];

      if (message is List) {
        throw ApiException(List<String>.from(message));
      } else if (message is String) {
        throw ApiException([message]);
      } else {
        throw ApiException(["Unknown error occurred"]);
      }
    } catch (_) {
      throw ApiException(["Unexpected error"]);
    }
  }
}

class ApiException implements Exception {
  final List<String> messages;

  ApiException(this.messages);

  @override
  String toString() {
    return messages.join(", ");
  }
}

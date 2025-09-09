import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moveis_app/data/models/user_model.dart';

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


}

class ApiException implements Exception {
  final List<String> messages;

  ApiException(this.messages);

  @override
  String toString() {
    return messages.join(", ");
  }
}

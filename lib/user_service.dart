import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl = "http://localhost:3000/users";

  Future<List> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> updateUser(int id, Map<String, dynamic> data) async {
    final http.Response response = await http.put(
      Uri.parse('$apiUrl/$id'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user.');
    }
  }

  Future<void> deleteUser(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user.');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://campus-booking-facility.onrender.com';

  static Future<List<dynamic>> getAll(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load $endpoint');
  }

  static Future<Map<String, dynamic>> getOne(String endpoint, int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load $endpoint/$id');
  }

  static Future<Map<String, dynamic>> create(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create $endpoint');
  }

  static Future<Map<String, dynamic>> update(
      String endpoint, int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to update $endpoint/$id');
  }

  static Future<void> delete(String endpoint, int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete $endpoint/$id');
    }
  }
}

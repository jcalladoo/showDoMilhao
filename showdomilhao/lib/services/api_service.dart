import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static String baseUrl = 'https://sua-api.com';
  String? token;
  String? role;

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'];
      role = data['role'];
      return true;
    } else {
      return false;
    }
  }

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/questions'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<bool> updateQuestion(Question question) async {
    if (role != 'professor') return false;

    final response = await http.put(
      Uri.parse('$baseUrl/questions/${question.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(question.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteQuestion(String id) async {
    if (role != 'professor') return false;

    final response = await http.delete(
      Uri.parse('$baseUrl/questions/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  }
}

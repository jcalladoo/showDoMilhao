// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  // ✅ Troque localhost por 10.0.2.2 se estiver usando Android Emulator
  static String baseUrl = 'http://192.168.15.1:3000';
  String? token;
  String? role;

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.trim().toLowerCase(),
          'password': password.trim(),
        }),
      );

      print('Login Status: \${response.statusCode}');
      print('Login Body: \${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token = data['token'];
        role = data['role'];
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      print('Login Exception: \${response.body}');
      print('Stack: $stack');
      return false;
    }
  }

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/questions'),
        headers: {'Authorization': 'Bearer \$token'},
      );

      print('Fetch Questions Status: \${response.statusCode}');
      print('Fetch Questions Body: \${response.body}');

      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        return jsonList.map((e) => Question.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load questions: \${response.statusCode}');
      }
    } catch (e) {
      print('Fetch Questions Exception: \$e');
      rethrow;
    }
  }

  Future<bool> updateQuestion(Question question) async {
    if (role != 'professor') return false;
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/questions/\${question.id}'),
        headers: {
          'Authorization': 'Bearer \$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(question.toJson()),
      );
      print('Update Question Status: \${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Update Question Exception: \$e');
      return false;
    }
  }

  Future<bool> deleteQuestion(String id) async {
    if (role != 'professor') return false;
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/questions/\$id'),
        headers: {'Authorization': 'Bearer \$token'},
      );
      print('Delete Question Status: \${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Delete Question Exception: \$e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user-info'),
        headers: {'Authorization': 'Bearer \$token'},
      );

      print('User Info Status: \${response.statusCode}');
      print('User Info Body: \${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Falha ao buscar informações do usuário');
      }
    } catch (e) {
      print('User Info Exception: \$e');
      rethrow;
    }
  }
}

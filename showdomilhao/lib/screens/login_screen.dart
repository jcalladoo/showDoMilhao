import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'question_editor_screen.dart';
import 'quiz_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _api = ApiService();
  bool _loading = false;

  void _submit() async {
    setState(() => _loading = true);
    final success = await _api.login(_emailController.text, _passwordController.text);

    if (!mounted) return;
    setState(() => _loading = false);

    if (success) {
      if (_api.role == 'professor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const QuestionEditorScreen()),
        );
      } else {
        final questions = await _api.fetchQuestions();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => QuizScreen(questions: questions)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login inválido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF16C5D1),
      body: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: Image.asset(
              'assets/images/logo.png',
              width: isSmallScreen ? 140 : 180,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 25, 131, 218)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'E-mail Poliedro',
                      filled: true,
                      fillColor: Color(0xFFE0E0E0),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Color(0xFFE0E0E0),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: const Text('Login', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

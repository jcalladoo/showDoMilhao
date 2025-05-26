import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/question.dart';
import 'quiz_screen.dart';
import 'login_screen.dart';
import 'subject_selection_screen.dart'; // 👈 Import da nova tela

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void goToSubjectSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SubjectSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF16C5D1),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => goToLogin(context),
                    child: const Text("Login", style: TextStyle(color: Colors.black)),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PoliEducação',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      FractionallySizedBox(
                        widthFactor: isSmallScreen ? 0.6 : 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => goToSubjectSelection(context), // 👈 atualizado
                          child: const Text('Jogar'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: isSmallScreen ? 0.6 : 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Ranking'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Image.asset(
                    'assets/images/character.png',
                    width: isSmallScreen ? 340 : 380,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: isSmallScreen ? 140 : 180,
                  ),
                ), 
              ],
            );
          },
        ),
      ),
    );
  }
}

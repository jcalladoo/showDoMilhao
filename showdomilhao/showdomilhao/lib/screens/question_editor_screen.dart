// lib/screens/question_editor_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/question.dart';

class QuestionEditorScreen extends StatelessWidget {
  const QuestionEditorScreen({super.key});

  void _navigateToAddQuestion(BuildContext context) {
    // TODO: navegar para tela de adicionar questão
  }

  void _navigateToDeleteQuestion(BuildContext context) {
    // TODO: navegar para tela de remover questão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16C5D1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToAddQuestion(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(30),
                  ),
                  child: const Icon(Icons.add, size: 48, color: Colors.black),
                ),
                const SizedBox(height: 8),
                const Text('Adicionar pergunta', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToDeleteQuestion(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(30),
                  ),
                  child: const Icon(Icons.block, size: 48, color: Colors.black),
                ),
                const SizedBox(height: 8),
                const Text('Remover pergunta', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

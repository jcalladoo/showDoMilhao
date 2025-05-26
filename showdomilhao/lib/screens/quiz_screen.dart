// lib/screens/quiz_screen.dart

import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  const QuizScreen({required this.questions, super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  int score = 0;

  void handleOptionTap(int index) {
    if (answered) return;
    setState(() {
      selectedIndex = index;
      answered = true;
    });
  }

  void nextQuestion() {
    if (selectedIndex == widget.questions[currentIndex].correctIndex) {
      score++;
    }
    setState(() {
      currentIndex++;
      selectedIndex = null;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= widget.questions.length) {
      return Scaffold(
        backgroundColor: const Color(0xFF16C5D1),
        body: Center(
          child: Text(
            'Fim do Quiz!\nPontuação: $score',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );
    }

    final question = widget.questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF16C5D1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                question.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...List.generate(question.options.length, (index) {
              final isCorrect = index == question.correctIndex;
              final isSelected = index == selectedIndex;

              Color optionColor = Colors.grey[300]!;
              if (answered) {
                if (isSelected) {
                  optionColor = isCorrect ? Colors.green : Colors.red;
                } else if (isCorrect) {
                  optionColor = Colors.green;
                }
              }

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Material(
                  color: optionColor,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => handleOptionTap(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(String.fromCharCode(65 + index)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              question.options[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            if (answered)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.skip_next, size: 32, color: Colors.black),
                  onPressed: nextQuestion,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
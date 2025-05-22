import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final void Function(int) onOptionSelected;

  const QuestionCard({required this.question, required this.onOptionSelected, super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int? selectedIndex;
  bool answered = false;

  void handleTap(int index) {
    if (answered) return;
    setState(() {
      selectedIndex = index;
      answered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.question.text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...List.generate(widget.question.options.length, (index) {
            final isCorrect = index == widget.question.correctIndex;
            final isSelected = index == selectedIndex;

            Color? optionColor;
            if (answered) {
              if (isSelected) {
                optionColor = isCorrect ? Colors.green : Colors.red;
              } else if (isCorrect) {
                optionColor = Colors.green;
              }
            }

            return Card(
              color: optionColor,
              child: ListTile(
                title: Text(widget.question.options[index]),
                onTap: () => handleTap(index),
              ),
            );
          }),
          const SizedBox(height: 24),
          if (answered)
            ElevatedButton(
              onPressed: () {
                if (selectedIndex != null) {
                  widget.onOptionSelected(selectedIndex!);
                }
              },
              child: const Text('Próxima'),
            ),
        ],
      ),
    );
  }
}

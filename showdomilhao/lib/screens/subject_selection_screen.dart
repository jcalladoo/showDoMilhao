import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/api_service.dart';
import 'quiz_screen.dart';

class SubjectSelectionScreen extends StatefulWidget {
  const SubjectSelectionScreen({super.key});

  @override
  State<SubjectSelectionScreen> createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen> {
  final Set<String> selectedSubjects = {};

  final List<_SubjectItem> subjects = [
    _SubjectItem(label: 'Exatas', icon: Icons.calculate, color: Colors.orange, key: 'exatas'),
    _SubjectItem(label: 'Linguagens', icon: Icons.abc, color: Colors.pink, key: 'linguagens'),
    _SubjectItem(label: 'Biológicas', icon: Icons.science, color: Colors.lightGreen, key: 'biologicas'),
    _SubjectItem(label: 'Humanas', icon: Icons.public, color: Colors.brown, key: 'humanas'),
  ];

  void _toggleSubject(String key) {
    setState(() {
      if (selectedSubjects.contains(key)) {
        selectedSubjects.remove(key);
      } else {
        selectedSubjects.add(key);
      }
    });
  }

  void _startFilteredQuiz() async {
    final questions = await ApiService().fetchQuestions();
    final filtered = questions.where((q) => selectedSubjects.contains(q.subject)).toList();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(questions: filtered)),
    );
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF16C5D1),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Image.asset(
                'assets/images/logo.png',
                width: isSmallScreen ? 100 : 120,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      alignment: WrapAlignment.center,
                      children: subjects.map((item) {
                        final isSelected = selectedSubjects.contains(item.key);
                        return GestureDetector(
                          onTap: () => _toggleSubject(item.key),
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(item.icon, size: 60, color: Colors.white),
                                      const SizedBox(height: 12),
                                      Text(
                                        item.label,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(Icons.check_circle, size: 32, color: Colors.black),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: selectedSubjects.isEmpty ? null : _startFilteredQuiz,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[700],
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Pronto!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: GestureDetector(
                          onTap: _goBack,
                          child: const Text(
                            '< Voltar',
                            style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectItem {
  final String key;
  final String label;
  final IconData icon;
  final Color color;

  _SubjectItem({
    required this.key,
    required this.label,
    required this.icon,
    required this.color,
  });
}

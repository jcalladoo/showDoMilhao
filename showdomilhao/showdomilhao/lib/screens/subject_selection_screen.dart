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
    _SubjectItem(label: 'Humanas', icon: Icons.public, color: Colors.yellow, key: 'humanas'),
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
        child: Column(
          children: [
            const SizedBox(height: 32),
            if (isSmallScreen)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: subjects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = subjects[index];
                    final isSelected = selectedSubjects.contains(item.key);
                    return GestureDetector(
                      onTap: () => _toggleSubject(item.key),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Center(child: Icon(item.icon, size: 40)),
                                if (isSelected)
                                  const Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Icon(Icons.check, size: 16, color: Colors.black),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.label,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: subjects.map((item) {
                  final isSelected = selectedSubjects.contains(item.key);
                  return GestureDetector(
                    onTap: () => _toggleSubject(item.key),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Center(child: Icon(item.icon, size: 40)),
                                if (isSelected)
                                  const Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Icon(Icons.check, size: 16, color: Colors.black),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.label,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: selectedSubjects.isEmpty ? null : _startFilteredQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Pronto!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _goBack,
                    child: const Text('< Voltar', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
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

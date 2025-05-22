import 'package:flutter/material.dart';
import 'package:showdomilhao/screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/question_editor_screen.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
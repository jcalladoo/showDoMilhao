// lib/models/question.dart

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String subject;

  Question({required this.id, required this.text, required this.options, required this.correctIndex, required this.subject});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'],
    text: json['text'],
    options: List<String>.from(json['options']),
    correctIndex: json['correctIndex'],
    subject: json['subject']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'options': options,
    'correctIndex': correctIndex,
  };
}

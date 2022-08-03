import 'package:quize/data/model/answer.dart';
import 'package:quize/data/model/correct_answers.dart';

class Quize {
  const Quize(
      {required this.answer,
      required this.category,
      required this.correctAnswer,
      required this.difficulty,
      required this.id,
      required this.question,
      this.explanation,
      this.description});

  final int id;
  final String question;
  final String? description;
  final Answer answer;
  final CorrectAnswer correctAnswer;
  final String? explanation;
  final String category;
  final String difficulty;

  factory Quize.fromJson(Map<String, dynamic> json) {
    return Quize(
        id: json['id'] as int,
        question: json['question'] as String,
        description: json['description'] as String?,
        answer: Answer.fromJson(json['answers']),
        correctAnswer: CorrectAnswer.fromJson(json['correct_answers']),
        explanation: json['explanation'] as String?,
        category: json['category'] as String,
        difficulty: json['difficulty'] as String);
  }
}

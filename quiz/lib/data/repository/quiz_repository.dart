import 'dart:convert';

import 'package:quize/constants.dart' as constants;
import 'package:quize/data/model/quiz.dart';
import 'package:http/http.dart' as http;

abstract class QuizRepository {
  /// Get quize questions by category and difficulty
  Future<List<Quiz>> getQuizeQuestions(String difficulty, String category);
}

class IQuizRepository implements QuizRepository {
  @override
  Future<List<Quiz>> getQuizeQuestions(
      String difficulty, String category) async {
    final questions = <Quiz>[];
    final queryParameters = {'apiKey': constants.apiKey, 'limit': '10'};
    final uri = Uri.parse(constants.endpointUrl)
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      for (final item in jsonResponse) {
        final question = Quiz.fromJson(item);
        questions.add(question);
      }
    }
    return questions;
  }
}

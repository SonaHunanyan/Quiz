import 'dart:convert';

import 'package:quize/constants.dart' as constants;
import 'package:quize/data/model/quize.dart';
import 'package:http/http.dart' as http;

abstract class QuizeRepository {
  /// Get quize questions by category and difficulty
  Future<List<Quize>> getQuizeQuestions(String difficulty, String category);
}

class IQuizeRepository implements QuizeRepository {
  @override
  Future<List<Quize>> getQuizeQuestions(
      String difficulty, String category) async {
    final questions = <Quize>[];
    final queryParameters = {'apiKey': constants.apiKey, 'limit': '10'};
    final uri = Uri.parse(constants.endpointUrl)
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      for (final item in jsonResponse) {
        final question = Quize.fromJson(item);
        questions.add(question);
      }
    }
    return questions;
  }
}

import 'package:equatable/equatable.dart';
import 'package:quize/data/model/quiz.dart';

abstract class QuizState extends Equatable {}

class QuizeInitialState extends QuizState {
  @override
  List<Object?> get props => [];
}

class QuestionsLoadedState extends QuizState {
  QuestionsLoadedState({required this.quizeQuestions});
  final List<Quiz> quizeQuestions;

  @override
  List<Object?> get props => [quizeQuestions];
}

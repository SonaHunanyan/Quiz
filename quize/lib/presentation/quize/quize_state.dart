import 'package:equatable/equatable.dart';
import 'package:quize/data/model/quize.dart';

abstract class QuizeState extends Equatable {}

class QuizeInitialState extends QuizeState {
  @override
  List<Object?> get props => [];
}

class QuestionsLoadedState extends QuizeState {
  QuestionsLoadedState({required this.quizeQuestions});
  final List<Quize> quizeQuestions;

  @override
  List<Object?> get props => [quizeQuestions];
}

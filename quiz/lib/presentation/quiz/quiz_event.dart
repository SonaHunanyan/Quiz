import 'package:equatable/equatable.dart';
import 'package:quize/data/model/result.dart';
import 'package:quize/presentation/home/category_widget.dart';
import 'package:quize/presentation/home/difficulty_widget.dart';

abstract class QuizEvent extends Equatable {}

class GetQuestionsEvent extends QuizEvent {
  GetQuestionsEvent({required this.difficulty, required this.category});
  final Difficulty difficulty;
  final Category category;

  @override
  List<Object?> get props => [difficulty,category];
}

class ResigstrateResult extends QuizEvent{
  ResigstrateResult({required this.result});
  final Result result;
  @override
  List<Object?> get props => [];
}

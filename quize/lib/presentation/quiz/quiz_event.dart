import 'package:equatable/equatable.dart';
import 'package:quize/data/model/result.dart';
import 'package:quize/presentation/home/home_screen.dart';

abstract class QuizEvent extends Equatable {}

class GetQuestionsEvent extends QuizEvent {
  GetQuestionsEvent({required this.difficulty});
  final Difficulty difficulty;

  @override
  List<Object?> get props => [difficulty];
}

class ResigstrateResult extends QuizEvent{
  ResigstrateResult({required this.result});
  final Result result;
  @override
  List<Object?> get props => [];
}

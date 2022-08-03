import 'package:equatable/equatable.dart';
import 'package:quize/presentation/home/home_screen.dart';

abstract class QuizEvent extends Equatable {}

class GetQuestionsEvent extends QuizEvent {
  GetQuestionsEvent({required this.difficulty});
  final Difficulty difficulty;

  @override
  List<Object?> get props => [difficulty];
}

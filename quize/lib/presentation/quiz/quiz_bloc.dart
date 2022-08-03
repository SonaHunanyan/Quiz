import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/data/repository/quiz_repository.dart';
import 'package:quize/presentation/home/home_screen.dart';
import 'package:quize/presentation/quiz/quiz_state.dart';
import 'quiz_event.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({required this.quizeRepository}) : super(QuizeInitialState()) {
    on<GetQuestionsEvent>(_onGetQuestions);
  }

  final QuizRepository quizeRepository;

  Future<void> _onGetQuestions(
      GetQuestionsEvent event, Emitter<QuizState> emit) async {
    final difficulty = event.difficulty;
    final difficlutyName = difficulty.name.toUpperCase();
    final category =
        difficulty == Difficulty.easy ? Category.linux : Category.cloud;
    final categoryName = category.name.toUpperCase();
    final questions =
        await quizeRepository.getQuizeQuestions(difficlutyName, categoryName);
    if (questions.isNotEmpty) {
      emit(QuestionsLoadedState(quizeQuestions: questions));
    }
  }
}

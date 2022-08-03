import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/data/repository/quize_repository.dart';
import 'package:quize/presentation/home/home_screen.dart';
import 'package:quize/presentation/quize/quize_event.dart';
import 'package:quize/presentation/quize/quize_state.dart';

class QuizeBloc extends Bloc<QuizeEvent, QuizeState> {
  QuizeBloc({required this.quizeRepository}) : super(QuizeInitialState()) {
    on<GetQuestionsEvent>(_onGetQuestions);
  }

  final QuizeRepository quizeRepository;

  Future<void> _onGetQuestions(
      GetQuestionsEvent event, Emitter<QuizeState> emit) async {
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

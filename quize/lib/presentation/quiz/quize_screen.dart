import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/data/model/quiz.dart';
import 'package:quize/data/repository/quiz_repository.dart';
import 'package:quize/presentation/home/home_screen.dart';
import 'package:quize/presentation/quiz/quiz_event.dart';
import 'package:quize/presentation/quiz/quiz_state.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/style.dart';

import 'quiz_bloc.dart';
import 'quiz_item_widget.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({Key? key, required this.selectedDifficulty})
      : super(key: key);
  final Difficulty selectedDifficulty;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizeScreen> {
  late final QuizBloc _quizeBloc;
  var _quizeQuestions = <Quiz>[];
  final _questionWidgets = <Widget>[];
  final _correctAnswersCount = ValueNotifier<int>(0);
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _quizeBloc = QuizBloc(quizeRepository: IQuizRepository())
      ..add(GetQuestionsEvent(difficulty: widget.selectedDifficulty));
    super.initState();
  }

  @override
  void dispose() {
    _quizeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
        create: (context) => _quizeBloc,
        child: BlocListener<QuizBloc, QuizState>(
            listener: _blocListener,
            child: BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) => _render())));
  }

  Widget _render() {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(),
          backgroundColor: colorPink,
        ),
        backgroundColor: colorWhite,
        body: _renderBody());
  }

  Widget _renderBody() {
    if (_quizeQuestions.isEmpty) {
      return const SizedBox();
    }
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: _questionWidgets,
    );
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 150), curve: Curves.ease);
  }
}

extension _StateAddition on _State {
  void _blocListener(BuildContext context, QuizState state) {
    if (state is QuestionsLoadedState) {
      _quizeQuestions = state.quizeQuestions;
      for (final element in _quizeQuestions) {
        _questionWidgets.add(QuizItemWidget(
            quizItem: element,
            correctAnswersCount: _correctAnswersCount,
            onNextButtonTap: _nextPage));
      }
    }
  }
}

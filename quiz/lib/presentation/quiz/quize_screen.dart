import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/data/model/quiz.dart';
import 'package:quize/data/model/result.dart';
import 'package:quize/data/repository/quiz_repository.dart';
import 'package:quize/data/repository/result_repository.dart';
import 'package:quize/presentation/home/category_widget.dart';
import 'package:quize/presentation/home/difficulty_widget.dart';
import 'package:quize/presentation/quiz/quiz_event.dart';
import 'package:quize/presentation/quiz/quiz_state.dart';
import 'package:quize/presentation/result/result_screen.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/style.dart';

import 'quiz_bloc.dart';
import 'quiz_item_widget.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen(
      {Key? key, required this.difficulty, required this.category})
      : super(key: key);
  final Difficulty difficulty;
  final Category category;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizeScreen> {
  late final QuizBloc _quizeBloc;
  var _quizeQuestions = <Quiz>[];
  var _isLoading = true;
  final _questionWidgets = <Widget>[];
  final _correctAnswersCount = ValueNotifier<int>(0);
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _quizeBloc = QuizBloc(
        quizeRepository: IQuizRepository(),
        resultRepository: IResultRepository())
      ..add(GetQuestionsEvent(
          difficulty: widget.difficulty, category: widget.category));
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
    if (_isLoading) {
      return Align(
          child: Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              child: const CircularProgressIndicator(color: colorPink)));
    }
    if (_quizeQuestions.isEmpty) {
      return const SizedBox();
    }
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: _questionWidgets,
    );
  }

  void _onFinish() {
    final result = Result(
        category: widget.category.name.toUpperCase(),
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        difficulty: widget.difficulty.name.toUpperCase(),
        trueCount: _correctAnswersCount.value,
        wrongCount: 10 - _correctAnswersCount.value);
    _quizeBloc.add(ResigstrateResult(result: result));
  }
}

extension _StateAddition on _State {
  void _blocListener(BuildContext context, QuizState state) {
    if (state is QuestionsLoadedState) {
      _isLoading = false;
      _quizeQuestions = state.quizeQuestions;
      for (final element in _quizeQuestions) {
        _questionWidgets.add(QuizItemWidget(
            quizItem: element,
            correctAnswersCount: _correctAnswersCount,
            pageController: _pageController,
            onFinish: _onFinish));
      }
    }
    if (state is ResultRegisrtatedState) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ResultScreen()));
    }
  }
}

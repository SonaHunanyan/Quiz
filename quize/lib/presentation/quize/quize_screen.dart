import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/data/model/quize.dart';
import 'package:quize/data/repository/quize_repository.dart';
import 'package:quize/presentation/home/home_screen.dart';
import 'package:quize/presentation/quize/quize_bloc.dart';
import 'package:quize/presentation/quize/quize_event.dart';
import 'package:quize/presentation/quize/quize_item_widget.dart';
import 'package:quize/presentation/quize/quize_state.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/style.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({Key? key, required this.selectedDifficulty})
      : super(key: key);
  final Difficulty selectedDifficulty;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizeScreen> {
  late final QuizeBloc _quizeBloc;
  var _quizeQuestions = <Quize>[];
  final _questionWidgets = <Widget>[];
  final _correctAnswersCount = ValueNotifier<int>(0);
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _quizeBloc = QuizeBloc(quizeRepository: IQuizeRepository())
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
    return BlocProvider<QuizeBloc>(
        create: (context) => _quizeBloc,
        child: BlocListener<QuizeBloc, QuizeState>(
            listener: _blocListener,
            child: BlocBuilder<QuizeBloc, QuizeState>(
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
  void _blocListener(BuildContext context, QuizeState state) {
    if (state is QuestionsLoadedState) {
      _quizeQuestions = state.quizeQuestions;
      for (final element in _quizeQuestions) {
        _questionWidgets.add(QuizeItemWidget(
            quizeItem: element,
            correctAnswersCount: _correctAnswersCount,
            onNextButtonTap: _nextPage));
      }
    }
  }
}

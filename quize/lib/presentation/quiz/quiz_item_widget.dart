import 'package:flutter/material.dart';
import 'package:quize/data/model/correct_answers.dart';
import 'package:quize/data/model/quiz.dart';
import 'package:quize/presentation/share/rounded_button.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

class QuizItemWidget extends StatefulWidget {
  const QuizItemWidget(
      {Key? key,
      required this.quizItem,
      required this.correctAnswersCount,
      required this.pageController,
      required this.onFinish})
      : super(key: key);
  final Quiz quizItem;
  final ValueNotifier<int> correctAnswersCount;
  final PageController pageController;
  final VoidCallback onFinish;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizItemWidget> with StateAddition {
  var _isCorrect = false;

  final _selectedAnswerNotifier = ValueNotifier<int?>(null);
  CorrectAnswer get _correctAnswer => widget.quizItem.correctAnswer;
  int? get _selectedAnswer => _selectedAnswerNotifier.value;
  PageController get _pageController => widget.pageController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _selectedAnswerNotifier,
        builder: (context, value, child) =>
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: _QuestionWidget(question: widget.quizItem.question)),
              Expanded(
                  child: GridView.count(
                      addSemanticIndexes: false,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      children: [
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 0,
                            _correctAnswer.answerA == true),
                        answer: widget.quizItem.answer.answerA,
                        onTap: () {
                          _selectedAnswerNotifier.value = 0;
                          _isCorrect = _correctAnswer.answerA == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 1,
                            _correctAnswer.answerB == true),
                        answer: widget.quizItem.answer.answerB,
                        onTap: () {
                          _selectedAnswerNotifier.value = 1;
                          _isCorrect = _correctAnswer.answerB == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 2,
                            _correctAnswer.answerC == true),
                        answer: widget.quizItem.answer.answerC,
                        onTap: () {
                          _selectedAnswerNotifier.value = 2;
                          _isCorrect = _correctAnswer.answerC == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 3,
                            _correctAnswer.answerD == true),
                        answer: widget.quizItem.answer.answerD,
                        onTap: () {
                          _selectedAnswerNotifier.value = 3;
                          _isCorrect = _correctAnswer.answerD == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 4,
                            _correctAnswer.answerE == true),
                        answer: widget.quizItem.answer.answerE,
                        onTap: () {
                          _selectedAnswerNotifier.value = 4;
                          _isCorrect = _correctAnswer.answerE == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 5,
                            _correctAnswer.answerF == true),
                        answer: widget.quizItem.answer.answerF,
                        onTap: () {
                          _selectedAnswerNotifier.value = 5;
                          _isCorrect = _correctAnswer.answerF == true;
                        }),
                  ])),
              Container(
                  height: 160,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                      child: RoundedButton(
                          onTap: _onNextButtonTap, title: 'Next')))
            ]));
  }

  Color _backgroundColor(bool isSelected, bool isCorrect) {
    if (!isSelected) {
      return colorGrey;
    }
    return isCorrect ? Colors.green : Colors.red;
  }

  void _onNextButtonTap() {
    if (_isCorrect) {
      widget.correctAnswersCount.value++;
    }
    _selectedAnswerNotifier.value = null;
    _nextPage();
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 150), curve: Curves.ease);
    _isCorrect = false;
    if (_pageController.page == 9) {
      widget.onFinish();
    }
  }
}

class _QuestionWidget extends StatelessWidget with StatelessAddition {
  _QuestionWidget({required this.question});
  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        width: width_(context) - 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colorPink, borderRadius: BorderRadius.circular(10)),
        child: Text(question,
            textAlign: TextAlign.center,
            style: getStyle(color: colorWhite, weight: FontWeight.w600)));
  }
}

class _AnswerWidget extends StatelessWidget with StatelessAddition {
  _AnswerWidget(
      {required this.answer,
      required this.onTap,
      this.backgroundColor = colorGrey});
  final String? answer;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (answer == null) {
      return const SizedBox();
    }
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
            child: Container(
                padding: const EdgeInsets.all(4),
                width: width_(context) / 2 - 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('$answer',
                    textAlign: TextAlign.center,
                    style: getStyle(
                        color: colorWhite, weight: FontWeight.w600)))));
  }
}

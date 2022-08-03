import 'package:flutter/material.dart';
import 'package:quize/data/model/correct_answers.dart';
import 'package:quize/data/model/quize.dart';
import 'package:quize/presentation/share/rounded_button.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

class QuizeItemWidget extends StatefulWidget {
  const QuizeItemWidget(
      {Key? key,
      required this.quizeItem,
      required this.correctAnswersCount,
      required this.onNextButtonTap})
      : super(key: key);
  final Quize quizeItem;
  final ValueNotifier<int> correctAnswersCount;
  final VoidCallback onNextButtonTap;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizeItemWidget> with StateAddition {
  var _isCorrect = false;

  final _selectedAnswerNotifier =ValueNotifier<int?>(null);
  CorrectAnswer get _correctAnswer => widget.quizeItem.correctAnswer;
  int? get _selectedAnswer => _selectedAnswerNotifier.value;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _selectedAnswerNotifier,
        builder: (context, value, child) =>
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: _QuestionWidget(question: widget.quizeItem.question)),
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
                        answer: widget.quizeItem.answer.answerA,
                        onTap: () {
                          _selectedAnswerNotifier.value = 0;
                          _correctAnswer.answerA == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 1,
                            _correctAnswer.answerB == true),
                        answer: widget.quizeItem.answer.answerB,
                        onTap: () {
                          _selectedAnswerNotifier.value = 1;
                          _correctAnswer.answerB == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 2,
                            _correctAnswer.answerC == true),
                        answer: widget.quizeItem.answer.answerC,
                        onTap: () {
                          _selectedAnswerNotifier.value = 2;
                          _correctAnswer.answerC == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 3,
                            _correctAnswer.answerD == true),
                        answer: widget.quizeItem.answer.answerD,
                        onTap: () {
                          _selectedAnswerNotifier.value = 3;
                          _correctAnswer.answerD == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 4,
                            _correctAnswer.answerE == true),
                        answer: widget.quizeItem.answer.answerE,
                        onTap: () {
                          _selectedAnswerNotifier.value = 4;
                          _correctAnswer.answerE == true;
                        }),
                    _AnswerWidget(
                        backgroundColor: _backgroundColor(_selectedAnswer == 5,
                            _correctAnswer.answerF == true),
                        answer: widget.quizeItem.answer.answerF,
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
    widget.onNextButtonTap.call();
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

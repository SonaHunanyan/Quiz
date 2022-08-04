import 'package:flutter/material.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

import 'description_widget.dart';

class DifficultyWidget extends StatelessWidget with StatelessAddition {
  DifficultyWidget({Key? key, required this.selectedDifficulty})
      : super(key: key);
  final ValueNotifier<Difficulty> selectedDifficulty;

  Color get _backgroundColor => colorGrey;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            height: 200,
            width: width_(context) / 2 - 20,
            decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: Difficulty.values.length + 1,
              itemBuilder: (BuildContext context, int index) =>
                  DescriptionTextWidget(
                title: title(index),
                onTap: () => _onTap(index),
                color: color(index),
              ),
            )));
  }

  Color color(int index) {
    if (index == 0 ||
        Difficulty.values[index - 1] != selectedDifficulty.value) {
      return colorWhite;
    }
    return colorPink;
  }

  void _onTap(int index) {
    if (index > 0) {
      selectedDifficulty.value = Difficulty.values[index - 1];
    }
  }

  String title(int index) {
    if (index == 0) {
      return 'DIFFICULTY';
    }
    return Difficulty.values[index - 1].name;
  }
}

enum Difficulty { easy, medium, hard }

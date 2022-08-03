import 'package:flutter/material.dart';
import 'package:quize/presentation/quize/quize_screen.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/presentation/share/rounded_button.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  var _selectedDiffilculty = Difficulty.easy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(),
          backgroundColor: colorPink,
        ),
        backgroundColor: colorWhite,
        body: _renderBody());
  }

  Widget _renderBody() {
    return SingleChildScrollView(
        child: Column(children: [
      _renderThemes(),
      RoundedButton(onTap: _onStartTap, title: 'Start')
    ]));
  }

  Widget _renderThemes() {
    return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _ThemeWidget(
              isSelected: _selectedDiffilculty == Difficulty.easy,
              difficulty: Difficulty.easy.name.toUpperCase(),
              category: Category.linux.name.toUpperCase(),
              onTap: _onEasyTap),
          _ThemeWidget(
              isSelected: _selectedDiffilculty == Difficulty.hard,
              difficulty: Difficulty.hard.name.toUpperCase(),
              category: Category.cloud.name.toUpperCase(),
              onTap: _onHardTap)
        ]));
  }

  void _onEasyTap() {
    setState(() {
      _selectedDiffilculty = Difficulty.easy;
    });
  }

  void _onHardTap() {
    setState(() {
      _selectedDiffilculty = Difficulty.hard;
    });
  }

  void _onStartTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => QuizeScreen(
              selectedDifficulty: _selectedDiffilculty,
            )));
  }
}

class _ThemeWidget extends StatelessWidget with StatelessAddition {
  const _ThemeWidget(
      {required this.isSelected,
      required this.difficulty,
      required this.category,
      required this.onTap});
  final bool isSelected;
  final String difficulty;
  final String category;
  final VoidCallback onTap;

  Color get _backgroundColor => isSelected ? colorPink : colorGrey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                height: 200,
                width: width_(context) / 2 - 20,
                decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  _DescriptionTextWidget(
                      title: 'Difficulty', value: difficulty),
                  _DescriptionTextWidget(title: 'Category', value: category)
                ]))));
  }
}

class _DescriptionTextWidget extends StatelessWidget {
  const _DescriptionTextWidget({required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text('$title : $value',
            style: getStyle(color: colorWhite, weight: FontWeight.w700)));
  }
}

enum Category { linux, cloud }

enum Difficulty { easy, hard }

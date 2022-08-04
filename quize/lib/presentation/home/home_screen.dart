import 'package:flutter/material.dart';
import 'package:quize/presentation/home/category_widget.dart';
import 'package:quize/presentation/quiz/quize_screen.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/presentation/share/rounded_button.dart';
import 'package:quize/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  final _selectedCategory = ValueNotifier<Category>(Category.linux);

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
          ValueListenableBuilder(
              valueListenable: _selectedCategory,
              builder: (context, value, child) =>
                  CategoryWidget(selectedCategory: _selectedCategory))
        ]));
  }

  void _onStartTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => QuizeScreen(
              selectedDifficulty: _selectedDiffilculty,
            )));
  }
}

enum Difficulty { easy, medium, hard }

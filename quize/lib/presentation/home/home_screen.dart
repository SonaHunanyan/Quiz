import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quize/constants.dart' as constants;
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
          title: _AppBarTitle(),
          backgroundColor: colorPink,
        ),
        backgroundColor: colorWhite,
        body: _renderBody());
  }

  Widget _renderBody() {
    return SingleChildScrollView(child: Column(children: [_renderThemes()]));
  }

  Widget _renderThemes() {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
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

  Future<void> fetchAlbum() async {
    final queryParameters = {'apiKey': constants.apiKey, 'limit': '10'};
    final uri = Uri.parse(constants.endpointUrl)
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    print(response);
  }
}

class _AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Quize',
        style: getStyle(color: colorWhite, weight: FontWeight.w700));
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
                height: 300,
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

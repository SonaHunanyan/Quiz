import 'package:flutter/material.dart';
import 'package:quize/data/model/result.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ResultScreen> {
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
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Result',
              textAlign: TextAlign.center,
              style: getStyle(
                  color: colorGrey, weight: FontWeight.w700, fontSize: 24),
            ))
      ],
    ));
  }
}

class _ResultItemWidget extends StatelessWidget with StatelessAddition {
  _ResultItemWidget({required this.result});
  final Result result;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: width_(context) - 50,
        color: colorGrey,
        child: Text(result.category, style: getStyle(color: colorWhite)));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quize/data/model/result.dart';
import 'package:quize/data/repository/result_repository.dart';
import 'package:quize/presentation/result/result_bloc.dart';
import 'package:quize/presentation/result/result_event.dart';
import 'package:quize/presentation/result/result_state.dart';
import 'package:quize/presentation/share/app_bar_title.dart';
import 'package:quize/presentation/share/rounded_button.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ResultScreen> with StateAddition {
  late final _resultBloc;
  var _results = <Result>[];

  @override
  void initState() {
    _resultBloc = ResultBloc(resultRepository: IResultRepository())
      ..add(GetResults());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultBloc>(
        create: ((context) => _resultBloc),
        child: BlocListener<ResultBloc, ResultState>(
            listener: _blocListener,
            child: BlocBuilder<ResultBloc, ResultState>(
                builder: (context, state) => _render())));
  }

  Widget _render() {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              'Results',
              textAlign: TextAlign.center,
              style: getStyle(
                  color: colorGrey, weight: FontWeight.w700, fontSize: 24),
            )),
        _results.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                    height: height_ - 310,
                    child: ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _ResultItemWidget(result: _results[index]),
                    ))),
        Container(
            alignment: Alignment.topCenter,
            height: 150,
            padding: const EdgeInsets.only(bottom: 10),
            child: RoundedButton(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                title: 'Finish'))
      ],
    ));
  }
}

extension _StateAddition on _State {
  void _blocListener(BuildContext context, ResultState state) {
    if (state is ResultsLoaded) {
      _results = state.results.reversed.toList();
    }
  }
}

class _ResultItemWidget extends StatelessWidget with StatelessAddition {
  _ResultItemWidget({required this.result});
  final Result result;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            alignment: Alignment.center,
            height: 200,
            width: width_(context) - 150,
            decoration: BoxDecoration(
                color: colorGrey, borderRadius: BorderRadius.circular(10)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _ResultField(title: 'Category', value: '${result.category}'),
              _ResultField(title: 'Difficulty', value: '${result.difficulty}'),
              _ResultField(
                  title: 'Right answers', value: '${result.trueCount}'),
              _ResultField(
                  title: 'Wrong answers', value: '${result.wrongCount}'),
              _ResultField(
                  title: 'Date Time', value: '${result.timeStamp.toDate}'),
            ])));
  }
}

class _ResultField extends StatelessWidget {
  const _ResultField({required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_TextWidget(text: title), _TextWidget(text: value)]));
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: getStyle(color: colorWhite, weight: FontWeight.w700));
  }
}

extension _TimeStampAddition on int? {
  String? get toDate {
    final timeStamp = this;
    if (timeStamp == null) {
      return '';
    }
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    final dateText = DateFormat('MM/dd/yy hh:mm').format(dateTime);
    return dateText;
  }
}

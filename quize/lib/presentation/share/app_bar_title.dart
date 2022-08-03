import 'package:flutter/material.dart';
import 'package:quize/style.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Quize',
        style: getStyle(color: colorWhite, weight: FontWeight.w700));
  }
}

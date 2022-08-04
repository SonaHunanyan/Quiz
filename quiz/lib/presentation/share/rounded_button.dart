import 'package:flutter/material.dart';
import 'package:quize/style.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                    color: colorPink, borderRadius: BorderRadius.circular(10)),
                child: Text(title,
                    style: getStyle(
                        color: colorWhite, weight: FontWeight.w600)))));
  }
}

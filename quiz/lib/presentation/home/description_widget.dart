import 'package:flutter/material.dart';
import 'package:quize/style.dart';

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget(
      {Key? key, required this.title, this.onTap, this.color = colorWhite})
      : super(key: key);
  final String title;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 5),
            child: Text(title.toUpperCase(),
                style: getStyle(color: color, weight: FontWeight.w700))));
  }
}

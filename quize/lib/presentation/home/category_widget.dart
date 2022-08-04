import 'package:flutter/material.dart';
import 'package:quize/presentation/state_addition_mixin.dart';
import 'package:quize/style.dart';

import 'description_widget.dart';

class CategoryWidget extends StatelessWidget with StatelessAddition {
  CategoryWidget({Key? key, required this.selectedCategory}) : super(key: key);
  final ValueNotifier<Category> selectedCategory;

  Color get _backgroundColor => colorGrey;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            height: 400,
            width: width_(context) / 2 - 20,
            decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: Category.values.length + 1,
              itemBuilder: (BuildContext context, int index) =>
                  DescriptionTextWidget(
                title: title(index),
                onTap: () => _onTap(index),
                color: color(index),
              ),
            )));
  }

  Color color(int index) {
    if (index == 0 || Category.values[index - 1] != selectedCategory.value) {
      return colorWhite;
    }
    return colorPink;
  }

  void _onTap(int index) {
    if (index > 0) {
      selectedCategory.value = Category.values[index - 1];
    }
  }

  String title(int index) {
    if (index == 0) {
      return 'DIFFICULTY';
    }
    return Category.values[index - 1].name;
  }
}

enum Category {
  linux,
  cloud,
  devOps,
  networking,
  programming,
  docker,
  kubernetes
}

library constants;

import 'package:flutter/cupertino.dart';

const int relativeWidth = 1000;
const int relativeHeight = 1000;

const String apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa';
const String endpointUrl = 'https://quizapi.io/api/v1/questions';

double rw(BuildContext context) {
  return rwWidth(MediaQuery.of(context).size.width);
}

double rh(BuildContext context) {
  return rwHeight(MediaQuery.of(context).size.height);
}

double rwHeight(double height) {
  return height / relativeHeight;
}

double rwWidth(double width) {
  return width / relativeWidth;
}

double grw(BuildContext context) {
  var grw = rw(context);
  return grw < 1 ? 1 : grw;
}

double grh(BuildContext context) {
  var grh = rh(context);
  return grh < 1 ? 1 : grh;
}

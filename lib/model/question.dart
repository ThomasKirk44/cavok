import 'package:flutter/foundation.dart';

class Question {
  Question({@required this.questionClearness});

  ///[questionClearness] this double variable from 0-1 defines how clear the question was and whether it can be understood.
  final double questionClearness;
}

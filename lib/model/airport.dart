import 'package:flutter/material.dart';

class Airport {
  Airport(
      {@required this.name,
      @required this.frequency,
      @required this.radioAbbreviation});
  final String name;
  final String radioAbbreviation;
  final double frequency;
}

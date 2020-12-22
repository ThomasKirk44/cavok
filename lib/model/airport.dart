import 'package:flutter/material.dart';

class Airport {
  Airport({@required this.name, @required this.frequency, @required this.icao});
  final String name;
  final String icao;
  final double frequency;
}

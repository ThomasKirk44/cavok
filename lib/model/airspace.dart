import 'package:cavok/model/radioTransmission.dart';
import 'package:flutter/material.dart';

class AirSpace {
  AirSpace(
      {@required this.name,
      @required this.radioFrequency,
      @required this.conversation});
  final double radioFrequency;
  final String name;
  final List<RadioTransmission> conversation;
}

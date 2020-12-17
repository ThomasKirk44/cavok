import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FrequencyPicker extends StatefulWidget {
  FrequencyPicker({this.onChanged});

  Function(double) onChanged;

  double _returnValue() {}

  @override
  _FrequencyPickerState createState() => _FrequencyPickerState();
}

class _FrequencyPickerState extends State<FrequencyPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumberPicker.integer(
            initialValue: 0, minValue: 0, maxValue: 9, onChanged: (value) {})
      ],
    );
  }
}

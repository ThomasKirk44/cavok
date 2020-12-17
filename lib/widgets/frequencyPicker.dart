import 'package:flutter/material.dart';

class FrequencyPicker extends StatefulWidget {
  FrequencyPicker({this.onChanged});

  Function(double) onChanged;

  double _returnValue() {}

  @override
  _FrequencyPickerState createState() => _FrequencyPickerState();
}

class _FrequencyPickerState extends State<FrequencyPicker> {
  int val = 8;

  double get totalValue {
    return double.parse("");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onVerticalDragEnd: (value) {
              setState(() {
                print(value);
                if (value.primaryVelocity.roundToDouble() < 0) {
                  val -= 1;
                } else {
                  val += 1;
                }
              });
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blueGrey, width: 5)),
              child: Center(
                child: Text(
                  "$val",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

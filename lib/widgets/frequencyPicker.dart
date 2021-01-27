import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FrequencyPicker extends StatefulWidget {
  FrequencyPicker(
      {@required this.onChanged, @required this.initialValue = "125.456"});
  Function(String) onChanged;
  String initialValue;

  @override
  _FrequencyPickerState createState() => _FrequencyPickerState();
}

class _FrequencyPickerState extends State<FrequencyPicker> {
  String resultValue = "";
  int _v1;
  int _v2;
  int _v3;
  int _v4;
  int _v5;
  int _v6;
  TextStyle selectedStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);

  TextStyle unselectedStyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.initialValue.length);
    print(widget.initialValue);
    _v1 =
        widget.initialValue.length >= 1 ? int.parse(widget.initialValue[0]) : 0;
    _v2 =
        widget.initialValue.length >= 2 ? int.parse(widget.initialValue[1]) : 0;
    _v3 =
        widget.initialValue.length >= 3 ? int.parse(widget.initialValue[2]) : 0;
    _v4 =
        widget.initialValue.length >= 5 ? int.parse(widget.initialValue[4]) : 0;
    _v5 =
        widget.initialValue.length >= 6 ? int.parse(widget.initialValue[5]) : 0;
    _v6 =
        widget.initialValue.length >= 7 ? int.parse(widget.initialValue[6]) : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 120,
      width: 160,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPicker.integer(
                selectedTextStyle: selectedStyle,
                textStyle: unselectedStyle,
                itemExtent: 40,
                listViewWidth: 20,
                haptics: true,
                infiniteLoop: true,
                initialValue: _v1,
                minValue: 0,
                maxValue: 9,
                onChanged: (value) {
                  setState(() {
                    _v1 = value;
                    resultValue = "$_v1$_v2$_v3.$_v4$_v5$_v6";
                    widget.onChanged(resultValue);
                  });
                }),
            NumberPicker.integer(
                selectedTextStyle: selectedStyle,
                textStyle: unselectedStyle,
                itemExtent: 40,
                listViewWidth: 20,
                haptics: true,
                infiniteLoop: true,
                initialValue: _v2,
                minValue: 0,
                maxValue: 9,
                onChanged: (value) {
                  setState(() {
                    _v2 = value;
                    resultValue = "$_v1$_v2$_v3.$_v4$_v5$_v6";
                    widget.onChanged(resultValue);
                  });
                }),
            NumberPicker.integer(
                selectedTextStyle: selectedStyle,
                textStyle: unselectedStyle,
                itemExtent: 40,
                listViewWidth: 20,
                haptics: true,
                infiniteLoop: true,
                initialValue: _v3,
                minValue: 0,
                maxValue: 9,
                onChanged: (value) {
                  setState(() {
                    _v3 = value;
                    resultValue = "$_v1$_v2$_v3.$_v4$_v5$_v6";
                    widget.onChanged(resultValue);
                  });
                }),
            Text(
              ".",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            NumberPicker.integer(
                selectedTextStyle: selectedStyle,
                textStyle: unselectedStyle,
                itemExtent: 40,
                listViewWidth: 20,
                haptics: true,
                infiniteLoop: true,
                initialValue: _v4,
                minValue: 0,
                maxValue: 9,
                onChanged: (value) {
                  setState(() {
                    _v4 = value;
                    resultValue = "$_v1$_v2$_v3.$_v4$_v5$_v6";
                    widget.onChanged(resultValue);
                  });
                }),
            NumberPicker.integer(
                selectedTextStyle: selectedStyle,
                textStyle: unselectedStyle,
                itemExtent: 40,
                listViewWidth: 20,
                haptics: true,
                infiniteLoop: true,
                initialValue: _v5,
                minValue: 0,
                maxValue: 9,
                onChanged: (value) {
                  setState(() {
                    _v5 = value;
                    resultValue = "$_v1$_v2$_v3.$_v4$_v5$_v6";
                    widget.onChanged(resultValue);
                  });
                }),
            NumberPicker.integer(
                selectedTextStyle: selectedStyle,
                textStyle: unselectedStyle,
                itemExtent: 40,
                listViewWidth: 20,
                haptics: true,
                infiniteLoop: true,
                initialValue: _v6,
                minValue: 0,
                maxValue: 9,
                onChanged: (value) {
                  setState(() {
                    _v6 = value;
                    resultValue = "$_v1$_v2$_v3.$_v4$_v5$_v6";
                    widget.onChanged(resultValue);
                  });
                })
          ],
        ),
      ),
    );
  }
}

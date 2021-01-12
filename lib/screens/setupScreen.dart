import 'package:cavok/data/airports.dart';
import 'package:cavok/model/aircrafts.dart';
import 'package:cavok/screens/radioView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../main.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  bool validator = false;
  var startingAirport = "";
  var endingAirport = "";
  var airplane = "";
  var _myActivities = ["start", "run", "test"];
  List<dynamic> airspaces = [];
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectorButton(
              errorText: "Starting must be selected",
              isBlank: startingAirport == "" && validator,
              title: "Starting Airport",
              pickerTitle: "Pick Airport",
              data: availableAirportNames,
              onchanged: (val) {
                setState(() {
                  startingAirport = val;
                  airspaces.clear();
                  print(airportNameIcao[startingAirport]);
                  assert(
                      airports[airportNameIcao[val]]
                          .availableAirspaces
                          .isNotEmpty,
                      "check the definition of the airport it seems like available airspaces were not added to it.");
                  airports[airportNameIcao[startingAirport]]
                      .availableAirspaces
                      .forEach((element) {
                    airspaces.add({"display": element, "value": element});
                    print(airspaces);
                  });
                });
              },
            ),
            SelectorButton(
              errorText: "Destination must be selected",
              isBlank: endingAirport == "" && validator,
              onchanged: (val) {
                setState(() {
                  endingAirport = val;
                });
              },
              title: "Destination Airport",
              data: availableAirportNames,
              pickerTitle: "Pick Airport",
            ),
            MultiSelectFormField(
              autovalidate: false,
              chipBackGroundColor: Colors.red,
              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
              checkBoxActiveColor: Colors.red,
              checkBoxCheckColor: Colors.green,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                "Select Airspaces",
                style: TextStyle(fontSize: 16),
              ),
              dataSource: airspaces,
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'OK',
              cancelButtonLabel: 'CANCEL',
              hintWidget: Text('Please choose one or more'),
              onSaved: (value) {
                // if (value == null) return;
                // setState(() {
                //   _myActivities = value;
                // });
              },
            ),
            SelectorButton(
              errorText: "airplane must be selected",
              isBlank: airplane == "" && validator,
              data: airplanes,
              onchanged: (val) {
                setState(() {
                  airplane = val;
                });
              },
              title: "Pick Airplane",
              pickerTitle: "Select Aircraft",
            ),
            RaisedButton(
                child: Text("Start"),
                onPressed: () {
                  if ((airplane == "") ||
                      (startingAirport == "") ||
                      (endingAirport == "")) {
                    setState(() {
                      validator = true;
                    });
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RadioView()));
                  }
                }),
            //FrequencyPicker()
          ],
        ),
      ),
    );
  }
}

class SelectorButton extends StatefulWidget {
  SelectorButton(
      {@required this.errorText,
      @required this.isBlank,
      this.onchanged,
      @required this.title,
      this.pickerTitle,
      @required this.data}) {
    if (this.pickerTitle == null) {
      this.pickerTitle = this.title;
    }
  }
  bool isBlank;
  Function(String) onchanged;
  String title;
  String pickerTitle;
  String errorText;
  List<String> data;

  @override
  _SelectorButtonState createState() => _SelectorButtonState();
}

class _SelectorButtonState extends State<SelectorButton> {
  String _resultText = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (widget.isBlank)
            ? Text(
                widget.errorText,
                style: TextStyle(color: Colors.red),
              )
            : (_resultText == "")
                ? Text("")
                : Text(_resultText),
        RaisedButton(
          child: Text(widget.title),
          onPressed: () {
            showMaterialScrollPicker(
              context: context,
              title: widget.pickerTitle,
              items: widget.data,
              selectedItem: _resultText,
              onChanged: (value) {
                setState(() => _resultText = value);
                widget.onchanged(value);
              },
            );
          },
        ),
      ],
    );
  }
}

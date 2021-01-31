import 'package:cavok/data/airports.dart';
import 'package:cavok/data/airspaces.dart';
import 'package:cavok/main.dart';
import 'package:cavok/model/aircrafts.dart';
import 'package:cavok/model/airspace.dart';
import 'package:cavok/screens/radioView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  bool validator = false;
  var _startingAirport = "";
  var _endingAirport = "";
  var airplane = "";
  var _myActivities = ["start", "run", "test"];
  List<dynamic> _airSpaces = [];
  List<AirSpace> _selectedAirspaces = [];
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
              isBlank: _startingAirport == "" && validator,
              title: "Starting Airport",
              pickerTitle: "Pick Airport",
              data: availableAirportNames,
              onchanged: (val) {
                setState(() {
                  _startingAirport = val;
                  print(airportIcaoName["EGNT"]);
                  _airSpaces.clear();
                  print(airportNameIcao[_startingAirport]);
                  assert(
                      airports[airportNameIcao[val]]
                          .availableAirspaces
                          .isNotEmpty,
                      "check the definition of the airport it seems like available airspaces were not added to it.");
                  airports[airportNameIcao[_startingAirport]]
                      .availableAirspaces
                      .forEach((element) {
                    _airSpaces.add({"display": element, "value": element});
                    print(_airSpaces);
                  });
                });
              },
            ),
            SelectorButton(
              errorText: "Destination must be selected",
              isBlank: _endingAirport == "" && validator,
              onchanged: (val) {
                setState(() {
                  _endingAirport = val;
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
              checkBoxCheckColor: Colors.white,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                "Select Airspaces",
                style: TextStyle(fontSize: 16),
              ),
              dataSource: _airSpaces,
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'OK',
              cancelButtonLabel: 'CANCEL',
              hintWidget: Text('Please choose one or more'),
              onSaved: (value) {
                print(value);
                print('selected');
                setState(() {
                  value.cast<String>().forEach((element) {
                    _selectedAirspaces.add(airSpaces[element]);
                  });

                  print(_selectedAirspaces);
                });
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
                      (_startingAirport == "") ||
                      (_endingAirport == "")) {
                    setState(() {
                      validator = true;
                    });
                  } else {
                    print("airspaces");
                    print(airSpaces[_airSpaces]);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RadioView(
                                  airspaces: _selectedAirspaces,
                                  startingAirport: airports[
                                      airportNameIcao[_startingAirport]],
                                  endingAirport:
                                      airports[airportNameIcao[_endingAirport]],
                                )));
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

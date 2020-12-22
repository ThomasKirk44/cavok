import 'dart:convert';

import 'package:flutter/widgets.dart';

class Airports {
  BuildContext context;
  var airports = [];

  Airports({this.context});

  void getData() async {
    final string = await DefaultAssetBundle.of(context)
        .loadString("assets/json/airports.json");
    final jsonResult = json.decode(string);
  }
}

import 'dart:convert';

import 'package:cavok/model/airport.dart';
import 'package:flutter/widgets.dart';

class Airports {
  BuildContext context;
  Map<String, dynamic> _airports;
  Map<String, dynamic> newList = {};

  Airports({@required this.context}) {
    _getData();
  }

  void _getData() async {
    final string = await DefaultAssetBundle.of(context)
        .loadString("assets/json/airports.json");
    final jsonResult = json.decode(string);
    _airports = jsonResult;
  }

  Airport getAirport(String fromIcaoCode) {
    assert(_airports.isNotEmpty, "airport data not yet loaded..");
    return Airport.fromJson(json: _airports, icaoCode: fromIcaoCode);
  }
}

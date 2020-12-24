import 'dart:convert';

import 'package:cavok/model/airport.dart';
import 'package:flutter/services.dart';

class Airports {
  Map<String, dynamic> _airports;
  Map<String, dynamic> newList = {};

  Airports() {
    _getData();
  }

  void _getData() async {
    final string = await rootBundle.loadString("assets/json/airports.json");
    final jsonResult = json.decode(string);
    _airports = jsonResult;
  }

  Airport getAirport(String fromIcaoCode) {
    assert(_airports.isNotEmpty, "airport data not yet loaded..");
    return Airport.fromJson(json: _airports, icaoCode: fromIcaoCode);
  }
}

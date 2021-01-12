import 'package:cavok/main.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:flutter/material.dart';

class AirportFields {
  static final icao = "icao";
  static final iata = "iata";
  static final name = "name";
  static final city = "city";
  static final state = "state";
  static final country = "country";
  static final elevation = "elevation";
  static final lat = "lat";
  static final lon = "lon";
  static final timeZone = "tz";
}

class Airport {
  List<RadioTransmission> startingAirportConversation;
  List<RadioTransmission> endingAirportConversation;
  List<String> availableAirspaces;
  String icao;
  String iata;
  String name;
  String city;
  String state;
  String country;
  int elevation;
  double lat;
  double lon;
  String timeZone;
  double towerFrequency;

  Airport(
      {@required String fromIcaoCode,
      @required double towerFrequency,
      @required List<RadioTransmission> startingAirportConversation,
      @required List<RadioTransmission> endingAirportConversation,
      @required List<String> availableAirspaces}) {
    var json = airportData;
    assert(json.isNotEmpty,
        "check the main.dart file, airport data doesn't seem to have loaded successfully for the airports");
    icao = json[fromIcaoCode.toUpperCase()][AirportFields.icao];
    iata = json[fromIcaoCode.toUpperCase()][AirportFields.iata];
    name = json[fromIcaoCode.toUpperCase()][AirportFields.name];
    city = json[fromIcaoCode.toUpperCase()][AirportFields.city];
    state = json[fromIcaoCode.toUpperCase()][AirportFields.state];
    country = json[fromIcaoCode.toUpperCase()][AirportFields.country];
    elevation = json[fromIcaoCode.toUpperCase()][AirportFields.elevation];
    lat = json[fromIcaoCode.toUpperCase()][AirportFields.lat];
    lon = json[fromIcaoCode.toUpperCase()][AirportFields.lon];
    timeZone = json[fromIcaoCode.toUpperCase()][AirportFields.timeZone];
    this.towerFrequency = towerFrequency;
    this.startingAirportConversation = startingAirportConversation;
    this.endingAirportConversation = endingAirportConversation;
    this.availableAirspaces = availableAirspaces;
    //todo add in frequency
  }
}

import 'package:cavok/model/radioTransmission.dart';
import 'package:flutter/material.dart';

import 'airspace.dart';

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
  List<AirSpace> availableAirspaces;
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
  double frequency;

  Airport.fromJson({Map<String, dynamic> json, @required String icaoCode}) {
    assert(json != null, "json was null for airport");
    icao = json[icaoCode.toUpperCase()][AirportFields.icao];
    iata = json[icaoCode.toUpperCase()][AirportFields.iata];
    name = json[icaoCode.toUpperCase()][AirportFields.name];
    city = json[icaoCode.toUpperCase()][AirportFields.city];
    state = json[icaoCode.toUpperCase()][AirportFields.state];
    country = json[icaoCode.toUpperCase()][AirportFields.country];
    elevation = json[icaoCode.toUpperCase()][AirportFields.elevation];
    lat = json[icaoCode.toUpperCase()][AirportFields.lat];
    lon = json[icaoCode.toUpperCase()][AirportFields.lon];
    timeZone = json[icaoCode.toUpperCase()][AirportFields.timeZone];
    frequency = 122.55;
    //todo add in frequency
  }

  Airport(
      {@required this.name,
      @required this.frequency,
      @required this.icao,
      this.startingAirportConversation,
      this.endingAirportConversation});
}

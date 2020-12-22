import 'dart:math';

import 'package:cavok/model/airport.dart';
import 'package:cavok/model/airspace.dart';

Random random = Random(200);

class Places {
  static final List<String> airports = [welshPool.name, newCastle.name];

  ///Airports
  static final Airport welshPool = Airport(
      name: "welshPool", icao: "WHL", frequency: random.nextDouble() * 150);
  static final Airport newCastle = Airport(
      name: "newCastle", icao: "ILG", frequency: random.nextDouble() * 150);

  ///AirSpace
  static final AirSpace shawbury =
      AirSpace(name: "shawbury", radioFrequency: random.nextDouble() * 150);
}
// final String welshpool = "welshPool";

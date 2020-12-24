import 'package:cavok/model/airspace.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:flutter/cupertino.dart';

import 'airport.dart';

class Flight {
  Airport startingAirport;
  List<AirSpace> airspace;
  Airport endingAirport;
  List<RadioTransmission> flightConversation;

  Flight(
      {@required this.startingAirport,
      @required this.endingAirport,
      @required this.airspace,
      this.flightConversation});
}

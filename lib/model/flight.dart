import 'package:cavok/model/airport.dart';
import 'package:cavok/model/airspace.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:flutter/cupertino.dart';

class Flight {
  Airport startingAirport;
  List<AirSpace> airspaces;
  Airport endingAirport;
  List<RadioTransmission> _flightConversation = [];
  List<RadioTransmission> get flightConversation {
    return _flightConversation;
  }

  Flight(
      {@required this.startingAirport,
      @required this.endingAirport,
      @required this.airspaces}) {
    assert(startingAirport.startingAirportConversation.isNotEmpty,
        "Starting Airport Conversation Cannot be empty");
    assert(endingAirport.endingAirportConversation.isNotEmpty,
        "ending Airport Conversation Cannot be empty");
    _flightConversation.addAll(startingAirport.startingAirportConversation);
    if (airspaces.isNotEmpty) {
      airspaces.forEach((airspace) {
        _flightConversation.addAll(airspace.conversation);
      });
    }
    _flightConversation.addAll(endingAirport.endingAirportConversation);
  }
}

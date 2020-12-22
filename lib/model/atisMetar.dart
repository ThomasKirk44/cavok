import 'dart:convert';

import 'package:cavok/model/airport.dart';
import 'package:cavok/model/metarReport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

/// Atis format
/// 1. Airport Name
/// 2. Time Zulu Time
/// 3. Runway in use
/// 4. Circuit Direction
/// 5. Wind Speed and Direction
/// 6. Visibility
/// 7. Cloud Cover
/// 8. Temperature
/// 9. Dew Point
/// 10. QNH (hectopascals)
/// 11. QFE
/// 12. Other Information tower frequency..

class MetarService {
  String _url;
  MetarReport data;
  bool reportIsMocked = false;
  final String _apiToken = "mlVfZcRWnk7OvV5j72Fc6wIDlzq9Ix7n8_29E"; //6K5ZNs";
  final Airport currentAirport;
  final String phoneNumber;
  final String currentReport = "";

  MetarService({@required this.currentAirport, this.phoneNumber}) {
    _url =
        "https://avwx.rest/api/metar/${currentAirport.icao}?token=$_apiToken";
  }

  Future<String> getCurrentData(BuildContext context) async {
    var result = await http.get(_url);
    if (result.statusCode == 200) {
      print("success");

      Map<String, dynamic> jsonData = json.decode(result.body);
      print(jsonData);
      data = MetarReport.fromJson(jsonData);
      print(data.time);
      return data.windSpeed;
    } else {
      reportIsMocked = true;
      print("http request failed");
      print(json.decode(result.body));
      print(result.statusCode);
      var string = await DefaultAssetBundle.of(context)
          .loadString("assets/json/mockMetar.json");
      var jsonData = json.decode(string);
      data = MetarReport.fromJson(jsonData);
      print(data);
    }
  }
}

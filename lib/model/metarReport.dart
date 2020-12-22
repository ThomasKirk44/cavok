class MetarFields {
  static final String spoken = "spoken";
  static final String dewPoint = "dewpoint";
  static final String temperature = "temperature";
  static final String units = "units";
  static final String altimeter = "altimeter";
  static final String flightRules = "flight_rules";
  static final String sanitized = "sanitized";
  static final String visibility = "visibility";
  static final String windDirection = "wind_direction";
  static final String windSpeed = "wind_speed";
  static final String meta = "meta";
  static final String metaTimeStamp = "timestamp";
}

class MetarReport {
  String dewPoint;
  String temperature;
  Map<String, dynamic> units;
  String altimeter;
  String flightRules;
  String sanitized;
  String visibility;
  String windDirection;
  String windSpeed;
  DateTime time;

  MetarReport.fromJson(Map<String, dynamic> json) {
    dewPoint = json[MetarFields.dewPoint][MetarFields.spoken];
    temperature = json[MetarFields.temperature][MetarFields.spoken];
    units = json[MetarFields.units];
    altimeter = json[MetarFields.altimeter][MetarFields.spoken];
    flightRules = json[MetarFields.flightRules];
    sanitized = json[MetarFields.sanitized];
    visibility = json[MetarFields.visibility][MetarFields.spoken];
    windDirection = json[MetarFields.windDirection][MetarFields.spoken];
    windSpeed = json[MetarFields.windSpeed][MetarFields.spoken];
    time = DateTime.parse(json[MetarFields.meta][MetarFields.metaTimeStamp]);
  }
}

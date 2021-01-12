import 'dart:convert';

import 'package:cavok/screens/setupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Map<String, dynamic> airportData = {};

///Map<Name, Icao>
Map<String, String> airportIcaoName = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  airportData =
      jsonDecode(await rootBundle.loadString('assets/json/airports.json'));
  airportData.forEach((key, value) {
    airportIcaoName[key] = value["name"];
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SetupScreen(),
    );
  }
}

import 'package:cavok/screens/setupScreen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).whenComplete(() => Navigator.push(
        context, MaterialPageRoute(builder: (context) => SetupScreen())));
  }

  void showLoadingIcon() {
    LoadingFlipping.square(
      borderColor: Colors.cyan,
      borderSize: 3.0,
      size: 30.0,
      backgroundColor: Colors.cyanAccent,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
          child: LoadingFlipping.circle(
        borderColor: Colors.red,
        borderSize: 0,
        size: 60.0,
        backgroundColor: Colors.cyanAccent,
        duration: Duration(milliseconds: 500),
      )),
    );
  }
}

import 'package:cavok/fonts/tower_icons.dart';
import 'package:flutter/material.dart';

class ControllerMessageBubble extends StatelessWidget {
  ControllerMessageBubble({@required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(
            Tower.radio_tower,
            size: 15,
          ),
          radius: 15,
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 100,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

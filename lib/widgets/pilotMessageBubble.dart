import 'package:flutter/material.dart';

class PilotMessageBubble extends StatelessWidget {
  PilotMessageBubble({@required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.airplanemode_active_outlined,
            size: 15,
            color: Colors.white,
          ),
          radius: 15,
        ),
      ],
    );
  }
}

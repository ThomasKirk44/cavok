import 'package:cavok/fonts/tower_icons.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class ControllerMessageBubble extends StatelessWidget {
  ControllerMessageBubble({@required this.message, this.highlightWords});
  final Map<String, HighlightedWord> highlightWords;
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
            child: TextHighlight(
              text: message,
              words: highlightWords,
              textStyle: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

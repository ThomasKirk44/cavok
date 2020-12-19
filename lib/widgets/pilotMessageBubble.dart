import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class PilotMessageBubble extends StatelessWidget {
  PilotMessageBubble({@required this.message, this.highlightWords});
  final Map<String, HighlightedWord> highlightWords;
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
            child: TextHighlight(
              text: message,
              words: highlightWords,
              textStyle: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
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

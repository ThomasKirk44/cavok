import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class PilotMessageBubble extends StatelessWidget {
  PilotMessageBubble(
      {@required this.message, this.highlightWords, this.bubbleWidth});
  final Map<String, HighlightedWord> highlightWords;
  final String message;
  final double bubbleWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: bubbleWidth,
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
          backgroundColor: Colors.grey.shade400,
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

import 'package:flutter/material.dart';

class HintBubble extends StatefulWidget {
  HintBubble(
      {@required this.hintText,
      this.onVisibilityChanged,
      this.delayInSeconds,
      this.bubbleWidth}) {
    assert(hintText != null, "hintText != null was true!");
  }
  double bubbleWidth;
  int delayInSeconds;
  String hintText;
  Function(bool) onVisibilityChanged;
  @override
  _HintBubbleState createState() => _HintBubbleState();
}

class _HintBubbleState extends State<HintBubble> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimationBox;
  Animation<Color> _colorAnimationText;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onVisibilityChanged(true);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward().whenComplete(
        () => Future.delayed(Duration(seconds: widget.delayInSeconds), () {
              if (mounted) {
                _animationController
                    .reverse()
                    .whenComplete(() => widget.onVisibilityChanged(false));
              }
            }));

    _colorAnimationBox = ColorTween(
            begin: Colors.transparent, end: Colors.blueGrey.withAlpha(50))
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _colorAnimationText =
        ColorTween(begin: Colors.transparent, end: Colors.black45)
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 2.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
      )),
      child: Container(
        width: widget.bubbleWidth,
        decoration: BoxDecoration(
            color: _colorAnimationBox.value,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.hintText,
              maxLines: 20,
              style: TextStyle(
                fontSize: 14,
                color: _colorAnimationText.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:audioplayer/audioplayer.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cavok/model/radioController.dart';
import 'package:cavok/widgets/controllerMessageBubble.dart';
import 'package:cavok/widgets/frequencyPicker.dart';
import 'package:cavok/widgets/pilotMessageBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RadioView extends StatefulWidget {
  @override
  _RadioViewState createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  final Map<String, HighlightedWord> _highlights = {
    'radio frequency': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  void speak(String speak) async {
    flutterTts.setVolume(1);
    flutterTts.setPitch(1);
    flutterTts.setSpeechRate(0.5);
    flutterTts.setLanguage("en-ZA");
    print(await flutterTts.getLanguages);
    print(await flutterTts.getVoices);
    await flutterTts.speak(speak);
  }

  FlutterTts flutterTts = FlutterTts();
  RadioController airTrafficControl = RadioController();
  AudioPlayer audioPlugin;
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  double _currentFrequency;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    audioPlugin = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: _isListening ? Colors.red : Colors.green,
          onPressed: () async {
            _listen();
            print("speak");
            //  await speak("Your tired??");
          },
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              child: SafeArea(
                child: Column(
                  children: [
                    ControllerMessageBubble(
                      highlightWords: _highlights,
                      message:
                          "safldksjfals;kdfjasl;kfajsfl;aksjfl;askjfas;ldkfjads;lfkjadsfl;kdsjfa;lskfjdasl;kfjsal;fkjasdl;fkjsda",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PilotMessageBubble(
                      message: _text,
                      highlightWords: _highlights,
                    ),
                    TextHighlight(
                      text: _text,
                      words: _highlights,
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FrequencyPicker()
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

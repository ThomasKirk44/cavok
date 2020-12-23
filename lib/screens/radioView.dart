import 'package:audioplayer/audioplayer.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cavok/model/airport.dart';
import 'package:cavok/model/radioController.dart';
import 'package:cavok/services/metarService.dart';
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
    'frequency': HighlightedWord(
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

  MetarService atisMetar;
  FlutterTts flutterTts = FlutterTts();
  RadioController airTrafficControl = RadioController();
  AudioPlayer audioPlugin;
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  String _currentFrequency = "000.00";
  String atisData;

  void showFrequencyPicker(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FrequencyPicker(
              initialValue: _currentFrequency.toString(),
              onChanged: (value) {
                _currentFrequency = value;
              },
            ),
            FlatButton(
                onPressed: () {
                  print(_currentFrequency);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Got It!',
                  style: TextStyle(color: Colors.purple, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  Future<void> getData() async {
    atisData = await atisMetar.getCurrentData(context);
  }

  @override
  void initState() {
    super.initState();
    Airport airport = Airport(icao: "KJFK");
    atisMetar = MetarService(currentAirport: airport);
    getData();
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
            // _listen();
            print("speak");
            // await airTrafficControl.speakPhonetic(forWord: atisData);
            showFrequencyPicker(context);
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
                          "Some Air-traffic Control message will be displayed here",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PilotMessageBubble(
                      message: _text,
                      highlightWords: _highlights,
                    ),
                    // TextHighlight(
                    //   text: _text,
                    //   words: _highlights,
                    //   textStyle: const TextStyle(
                    //     fontSize: 32.0,
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
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

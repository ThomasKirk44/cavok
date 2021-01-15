import 'package:audioplayer/audioplayer.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cavok/model/airport.dart';
import 'package:cavok/model/airspace.dart';
import 'package:cavok/model/radioController.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:cavok/model/requiredWord.dart';
import 'package:cavok/services/metarService.dart';
import 'package:cavok/widgets/controllerMessageBubble.dart';
import 'package:cavok/widgets/frequencyPicker.dart';
import 'package:cavok/widgets/hintBubble.dart';
import 'package:cavok/widgets/pilotMessageBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RadioView extends StatefulWidget {
  Airport startingAirport;
  Airport endingAirport;
  List<AirSpace> airspaces;

  RadioView({this.airspaces, this.startingAirport, this.endingAirport});

  @override
  _RadioViewState createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  List<RadioTransmission> _flightConversation;
  final Map<String, HighlightedWord> _highlights = {
    'frequency': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'runway': HighlightedWord(
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
  bool _hintBubbleVisible = false;
  String _text = 'Press the button and start speaking';
  String _hintText;
  double _confidence = 1.0;
  String _currentFrequency = "000.00";
  String atisData;
  final player = AudioCache();

  void showHintBubble(String withText) {
    setState(() {
      _hintText = withText;
      _hintBubbleVisible = !_hintBubbleVisible;
    });
  }

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
            Text(
              "Frequency".toUpperCase(),
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
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
                  'Change',
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
    _flightConversation
        .addAll(widget.startingAirport.startingAirportConversation);
    widget.airspaces.forEach((e) => _flightConversation.addAll(e.conversation));
    _flightConversation.addAll(widget.endingAirport.endingAirportConversation);
    Airport airport = Airport(fromIcaoCode: "KJFK");
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
            _listen(onFinished: (result) {
              RadioTransmission(
                      showHintBubbleWIthMessage: (message) {
                        showHintBubble(message);
                      },
                      informationText: "change frequency to 126.35",
                      pilotDialogue: ["this is a test"],
                      towerResponseSoundFileLocation:
                          "tripAudio/newcastle-welshpool/1.mp3",
                      towerErrorResponseSoundFileLocation:
                          "tripAudio/newcastle-welshpool/3.mp3",
                      requiredWords: [
                        RequiredWord(wordPermutations: ["test"])
                      ],
                      errorHintText: "hint error hint")
                  .respondToPilotDialogue(
                      textToSpeechOutput: result,
                      onUndiscernableSpeech: (failedText, clarity) {
                        print(result);
                      });
            });
            print("speak");
            // await airTrafficControl.speakPhonetic(forWord: atisData);
            RadioTransmission();

            //showFrequencyPicker(context);
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
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
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
                        SizedBox(
                          height: 300,
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
                    _hintBubbleVisible
                        ? HintBubble(
                            delayInSeconds: 4,
                            hintText: _hintText,
                            onVisibilityChanged: (bool) {
                              if (bool == false) {
                                setState(() {
                                  _hintBubbleVisible = bool;
                                });
                              }
                            },
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listen({Function(String resultText) onFinished}) async {
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
      onFinished(_text);
    }
  }
}

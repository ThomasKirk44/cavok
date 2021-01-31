import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cavok/data/airspaces.dart';
import 'package:cavok/model/airport.dart';
import 'package:cavok/model/airspace.dart';
import 'package:cavok/model/radioController.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:cavok/services/metarService.dart';
import 'package:cavok/widgets/frequencyPicker.dart';
import 'package:cavok/widgets/hintBubble.dart';
import 'package:cavok/widgets/pilotMessageBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

//todo add hint text at the beginning of each message.

class RadioView extends StatefulWidget {
  Airport startingAirport;
  Airport endingAirport;
  List<AirSpace> airspaces;

  RadioView({this.airspaces, this.startingAirport, this.endingAirport});

  @override
  _RadioViewState createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  List<RadioTransmission> _flightConversation = [];
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
  stt.SpeechToText _speech;
  bool _isListening = false;
  bool _hintBubbleVisible = false;
  String _text = 'Press the button and start speaking';
  String _hintText = "k";
  double _confidence = 1.0;
  String _currentFrequency = "000.00";
  String atisData;
  RadioTransmission _currentTransmission;
  final player = AudioCache();
  List<int> _airSpaceConvoLengths = [];
  List<String> _atisMessageLocations = [];

  ///index for keeping track of when the next atisMessage should be shown.
  int _currentAtisConversationLengthIndex = 0;

  /// for keeping track of which radio transmission we are currently on.
  int _currentMessageIndex = 0;

  /// for keeping track of which atis message we are currently are on.
  int _currentAtisMessageIndex = 0;

  @override
  void initState() {
    super.initState();
//todo remove this code in production this is just for testing purposes
    _loadConversation();
    showHintBubble(_flightConversation[_currentMessageIndex].initialMessage);
    Airport airport = Airport(fromIcaoCode: "KJFK");
    atisMetar = MetarService(currentAirport: airport);
    getData();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.fixedPlayer.dispose();
  }

  void disposeAndRebuildPlayer() {
    _flightConversation[_currentMessageIndex].disposeAudioPlayer();
    if (player.fixedPlayer != null) {
      player.fixedPlayer.dispose();
    } else {
      player.fixedPlayer = AudioPlayer();
    }
  }

  void _loadConversation() {
    //load atisMessage Locations
    _atisMessageLocations.add(widget.startingAirport.atisAudioFile ?? "");
    widget.airspaces.forEach((element) {
      _atisMessageLocations.add(element.atisMessageLocation ?? "");
    });
    _atisMessageLocations.add(widget.endingAirport.atisAudioFile ?? "");
    print("atisFileLocations: ${_atisMessageLocations}");

    int atisIndex = 0;
    //load conversation lengths, this will help later keep track of which atis message we are supposed to be on.
    _airSpaceConvoLengths
        .add(widget.startingAirport.startingAirportConversation.length);
    widget.airspaces.forEach((e) {
      _airSpaceConvoLengths
          .add(e.conversation.length + _airSpaceConvoLengths[atisIndex]);
      atisIndex += 1;
    });
    _airSpaceConvoLengths.add(
        widget.endingAirport.endingAirportConversation.length +
            _airSpaceConvoLengths[atisIndex]);
    print("calculated Lengths: $_airSpaceConvoLengths");

    //load conversations
    print(
        "actual lengths: ${widget.startingAirport.startingAirportConversation.length}");
    widget.airspaces.forEach((element) {
      print(element.conversation.length);
    });
    print(widget.endingAirport.endingAirportConversation.length);

    _flightConversation =
        List.from(widget.startingAirport.startingAirportConversation);
    airSpaces.forEach((e, j) {
      _flightConversation.addAll(j.conversation);
    });
    _flightConversation.addAll(widget.endingAirport.endingAirportConversation);
  }

  void _updateMessageIndex() {
    if ((_flightConversation.length - 1) > _currentMessageIndex) {
      if ((_airSpaceConvoLengths[_currentAtisConversationLengthIndex] - 1) ==
          _currentMessageIndex) {
        _currentAtisConversationLengthIndex += 1;
        _currentAtisMessageIndex += 1;
      }
      _currentMessageIndex += 1;
    } else {
      _showCompletedDialogue();
    }
  }

  void _giveUserHint() {
    if (_flightConversation[_currentMessageIndex].pilotDialogue[0] != null) {
      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        showHintBubble(
            "Say: ${_flightConversation[_currentMessageIndex].initialMessage ?? "No hint available"}");
      });
    }
  }

  void showHintBubble(String withText) {
    print(withText);
    assert(withText != null, "text is null");
    setState(() {
      _hintText = withText;
      _hintBubbleVisible = !_hintBubbleVisible;
    });
  }

  void showFrequencyPicker(
      BuildContext context, double frequency, bool validFrequency,
      {Function onComplete}) {
    Dialog frequencyPickerDialog = Dialog(
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
            !validFrequency
                ? Text("Incorrect Frequency",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w300))
                : Text(""),
            SizedBox(
              height: 20,
            ),
            FrequencyPicker(
              initialValue: _currentFrequency.toString(),
              onChanged: (value) {
                _currentFrequency = value;
                print(_currentFrequency);
              },
            ),
            FlatButton(
                onPressed: () {
                  print(_currentFrequency);
                  onComplete();
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
        context: context,
        builder: (BuildContext context) => frequencyPickerDialog);
  }

  void _recursiveFrequencyPicker(double frequency, bool validFrequency) async {
    await showFrequencyPicker(context, frequency, validFrequency,
        onComplete: () {
      if (frequency != double.parse(_currentFrequency)) {
        player
            .play("tripAudio/generic/static.wav")
            .timeout(Duration(seconds: 2))
            .whenComplete(() {
          Navigator.of(context).pop();
          _recursiveFrequencyPicker(frequency, false);
        });
      } else {
        Navigator.of(context).pop();
        showHintBubble(
            "You are on the right frequency. Hint: ${_flightConversation[_currentMessageIndex].initialMessage}");
      }
    });
  }

  Future<void> getData() async {
    atisData = await atisMetar.getCurrentData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.airplanemode_active_rounded),
              onPressed: () {
                disposeAndRebuildPlayer();
                if (_atisMessageLocations[_currentAtisMessageIndex] != "") {
                  player.play(_atisMessageLocations[_currentAtisMessageIndex]);
                } else {
                  showHintBubble(
                      "There is no available Atis/Metar in this airspace");
                }
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 5),
            child: GestureDetector(
              onTap: () {
                if (exceptionAware(() =>
                        _flightConversation[_currentMessageIndex]
                            .pilotDialogue[0]) !=
                    null) {
                  showHintBubble(
                      "Say: ${_flightConversation[_currentMessageIndex].pilotDialogue[0] ?? "No hint available"}");
                } else {
                  showHintBubble("Try saying anything");
                }
              },
              child: Column(
                children: [
                  Icon(Icons.lightbulb_outline),
                  Text(
                    "Hint",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          )
        ],
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
            print("current index: $_currentMessageIndex");
            _listen(onFinished: (result) {
              print(result);
              _flightConversation[_currentMessageIndex].respondToPilotDialogue(
                  textToSpeechOutput: result,
                  onUndiscernableSpeech: (failedText, clarity) {
                    print(result);
                  },
                  showFrequencyPicker: (frenq) {
                    _recursiveFrequencyPicker(frenq, true);
                  },
                  showErrorHintBubble: (message) {
                    showHintBubble(message);
                  },
                  onFinished: (bool) {
                    if (bool) {
                      _updateMessageIndex();
                      _giveUserHint();
                    }
                  });
            });
            // await airTrafficControl.speakPhonetic(forWord: atisData);

            //showFrequencyPicker(context);
          },
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          _hintBubbleVisible
              ? Positioned(
                  bottom: 170,
                  child: HintBubble(
                    bubbleWidth: MediaQuery.of(context).size.width * 0.9,
                    delayInSeconds: 4,
                    hintText: _hintText,
                    onVisibilityChanged: (bool) {
                      if (bool == false) {
                        setState(() {
                          _hintBubbleVisible = bool;
                        });
                      }
                    },
                  ),
                )
              : Container(),
          Positioned(
            top: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: PilotMessageBubble(
                  message: _text,
                  highlightWords: _highlights,
                  bubbleWidth: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletedDialogue() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Congrats you finished the flight!",
      desc: "You're becoming a pro!",
      buttons: [
        DialogButton(
          child: Text(
            "Complete Flight",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  void _listen({Function(String resultText) onFinished}) async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _flightConversation[_currentMessageIndex].disposeAudioPlayer();
        disposeAndRebuildPlayer();
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

import 'package:audioplayer/audioplayer.dart';
import 'package:cavok/model/airport.dart';
import 'package:cavok/model/question.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RadioController {
  RadioController();

  Airport currentAirport;
  FlutterTts _flutterTts = FlutterTts();
  AudioPlayer audioPlugin = AudioPlayer();
  List<String> randomAtisConditions = [
    """Stansted information Hotel, time 2150.
Runway in use: two-two. Expect an ILS approach
Ground is closed, delivery is closed
Surface wind two-one-zero, one-one knots
Visibility one-zero kilometers or more
Slight rain
Broken 700 feet, overcast 1100 feet
Temperature: plus niner, dew point plus eight
QNH: niner-eight-two hectopascal
Transition Level: Flight Level seven zero
Runway two-two: wet-wet-wet
Acknowledge receipt of information Hotel and advise aircraft type on first contact""",
    """Stansted information Hotel, time 18:50.
Runway in use: two-two. Expect an ILS approach
Ground is closed, delivery is closed
Surface wind two-one-zero, one-one knots
Visibility one-zero kilometers or more
Slight rain
Broken 700 feet, overcast 1100 feet
Temperature: plus niner, dew point plus eight
QNH: niner-eight-two hectopascal
Transition Level: Flight Level seven zero
Runway two-two: wet-wet-wet
Acknowledge receipt of information Hotel and advise aircraft type on first contact"""
  ];

  ///[script] this list defines how the controller will respond to audio input.
  Map<Question, String> script;

  ///altitudes read in the thousands not individually..
  Map<String, String> aviationAlphabet = {
    "a": "alpha",
    "b": "bravo",
    "c": "charlie",
    "d": "delta",
    "e": "echo",
    "f": "foxtrot",
    "h": "hotel",
    "g": "golf",
    "i": "india",
    "j": "juliett",
    "k": "kilo",
    "l": "lima",
    "m": "mike",
    "n": "november",
    "o": "oscar",
    "p": "papa",
    "q": "quebec",
    "r": "romeo",
    "s": "sierra",
    "t": "tango",
    "u": "uniform",
    "v": "victor",
    "w": "whiskey",
    "x": "xray",
    "y": "yankee",
    "z": "zulu",
    "1": "one",
    "2": "two",
    "3": "three",
    "4": "four",
    "5": "five",
    "6": "six",
    "7": "seven",
    "8": "eight",
    "9": "niner",
    "0": "zero"
  };

  Future<void> speak(String speak) async {
    _flutterTts.setVolume(1);
    _flutterTts.setPitch(1);
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setLanguage("en-GB");
    // print(await _flutterTts.getLanguages);
    //  print(await _flutterTts.getVoices);
    await _flutterTts.speak(speak);
  }

  Future<void> speakPhonetic({String forWord}) async {
    forWord.toLowerCase().runes.forEach((int rune) async {
      var character = new String.fromCharCode(rune);
      if (character != ' ') {
        print(character);
        await speak(aviationAlphabet["$character"].toString());
      }
    });
  }

  Future<void> speakRandomAtis() {
    speak(randomAtisConditions[1]);
  }

  String askQuestion(Question question) {
    if (question.questionClearness < 0.8)
      return ("Sorry I didnt get that can you please repeat?");
  }
}

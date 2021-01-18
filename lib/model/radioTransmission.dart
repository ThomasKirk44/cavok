import 'package:audioplayers/audio_cache.dart';
import 'package:cavok/model/requiredWord.dart';
import 'package:flutter/foundation.dart';
import 'package:string_similarity/string_similarity.dart';

class RadioTransmission {
  RadioTransmission({
    @required this.pilotDialogue,
    @required this.towerResponseSoundFileLocation,
    this.towerErrorResponseSoundFileLocation,
    this.errorHintText,
    this.showFrequencyPicker,
    this.requiredFrequency,
    this.requiredWords,
    this.responseDelay = const Duration(seconds: 4),
    this.checkForPilotDialogueMatching = true,
    this.requiredWordsMissingHintText,
    this.showHintBubbleWIthMessage,
    this.informationText,
  });

  ///[pilotDialogue] questions can be asked in more than one way so a list is supplied of possible questions. to ensure the system understands what the person is trying to say.
  final List<String> pilotDialogue;

  ///[towerResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerResponseSoundFileLocation;

  ///[towerErrorResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerErrorResponseSoundFileLocation;

  static final String _sayAgainMessageLocation =
      "tripAudio/generic/Say again.mp3";

  ///[informationText] include information for the pilot
  final String informationText;

  ///[errorHintText] if you would like hintText to be shown after the answer has been given then include the hint text.
  final String errorHintText;

  ///[requiredWordsMissingHintText] if one of the required words are missing use this hint text
  final String requiredWordsMissingHintText;

  ///[requiredFrequency] if shouldShowFrequencyPicker make sure the frequency matches required Frequency
  final double requiredFrequency;

  ///[requiredWords] if these words are not included in the transmission show the hint Text.
  final List<RequiredWord> requiredWords;

  ///[responseDelay] the number of seconds for the tower to respond
  final Duration responseDelay;

  ///[checkForPilotDialogueMatching] default = true; if false any message can be used.
  final bool checkForPilotDialogueMatching;

  ///[showHintBubbleWIthMessage] implement this callback to pass the message to the UI hint bubble
  final Function(String) showHintBubbleWIthMessage;

  ///[showFrequencyPicker] shows the frequency picker and passes the required frequency to it.
  final Function(double) showFrequencyPicker;

  ///[_player] for playing response audio files.
  final _player = AudioCache();

  /// responds appropriately to the [textToSpeechOutput] give from text to speech
  /// [onUndiscernableSpeech] is a callback that gives you the text that Failed
  /// [onFinished] is a callback that notifies the view when the next transmission should be played
  void respondToPilotDialogue(
      {String textToSpeechOutput,
      Function(
        String failedText,
        double clarity,
      )
          onUndiscernableSpeech,
      Function(String) showHintBubble,
      Function(double) showFrequencyPicker,
      Function(bool) onFinished}) async {
    if (requiredWords != null) {
      if (!_requiredWordsIncluded(forString: textToSpeechOutput)) {
        print("not included");
        print(_requiredWordsIncluded(forString: textToSpeechOutput));
        if (towerResponseSoundFileLocation != null) {
          _player.play(towerErrorResponseSoundFileLocation);
        }
        _checkForNullHint(
            callBackFunction: showHintBubble,
            message: "try saying: ${pilotDialogue[0]}");
      }
      _checkForNullFrequency(callBackFunction: showFrequencyPicker);
    } else {
      //states what the pilot said is the correct thing,
      //what the pilot said wasnt the right thing
      //  was wrong because required words were missing
      //  was wrong just because the match rating wasn't high enough.

      if (checkForPilotDialogueMatching) {
        double checkResult = 0;
        pilotDialogue.forEach((element) {
          if (textToSpeechOutput.similarityTo(element) > checkResult) {
            checkResult = textToSpeechOutput.similarityTo(element);
          }
        });
        if (checkResult > 0.5) {
          await Future.delayed(responseDelay);
          if (towerResponseSoundFileLocation != null) {
            _player.play(towerResponseSoundFileLocation);
          }
          _checkForNullHint(
              callBackFunction: showHintBubble, message: informationText);
          onFinished(true);
        } else {
          await Future.delayed(responseDelay);
          _player.play(_sayAgainMessageLocation).whenComplete(() {
            _checkForNullFrequency(callBackFunction: showFrequencyPicker);
            _checkForNullHint(
                callBackFunction: showHintBubble,
                message: "try saying: ${pilotDialogue[0]}");
          });
          onUndiscernableSpeech(textToSpeechOutput, checkResult);
        }
      } else {
        _player.play(towerResponseSoundFileLocation).whenComplete(() {
          _checkForNullFrequency(callBackFunction: showFrequencyPicker);
          _checkForNullHint(
              callBackFunction: showHintBubble, message: informationText);
          onFinished(true);
        });
      }
    }
  }

  void _checkForNullHint({Function(String) callBackFunction, String message}) {
    if (message != null) {
      callBackFunction(message);
    }
  }

  void _checkForNullFrequency({Function(double) callBackFunction}) {
    if (requiredFrequency != null) {
      callBackFunction(requiredFrequency);
    }
  }

  bool _checkRequiredWord(RequiredWord word, String checkInString) {
    bool isIncluded = false;

    for (var each in word.wordPermutations) {
      if (checkInString.toLowerCase().contains(each.toLowerCase())) {
        return true;
      }
    }
    return isIncluded;
  }

  bool _requiredWordsIncluded({String forString}) {
    assert(requiredWords != null,
        "Error Tried to check for missing words but requiredWords == null");
    //all required words must be present
    //for each required word there must be at least one required word that is included.

    for (var requiredWord in requiredWords) {
      print(
          "requiredWord ${requiredWord.wordPermutations[0]} : ${_checkRequiredWord(requiredWord, forString)}");
      if (!_checkRequiredWord(requiredWord, forString)) {
        return false;
      }
    }
    return true;
  }
}
// make stack of questions, with answers if they get it wrong promt them on what to say.

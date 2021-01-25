import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cavok/model/requiredWord.dart';
import 'package:flutter/foundation.dart';
import 'package:string_similarity/string_similarity.dart';

class RadioTransmission {
  RadioTransmission(
      {@required this.pilotDialogue,
      @required this.towerResponseSoundFileLocation,
      this.towerErrorResponseSoundFileLocation,
      this.errorHintMessage,
      this.requiredFrequency,
      this.requiredWords,
      this.responseDelay = const Duration(seconds: 4),
      this.checkForPilotDialogueMatching = true,
      this.startingHintMessage,
      this.endingHintMessage});

  ///[pilotDialogue] questions can be asked in more than one way so a list is supplied of possible questions. to ensure the system understands what the person is trying to say.
  final List<String> pilotDialogue;

  ///[towerResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerResponseSoundFileLocation;

  ///[towerErrorResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerErrorResponseSoundFileLocation;

  static final String _sayAgainMessageLocation =
      "tripAudio/generic/Say again.mp3";

  ///[startingHintMessage] include information for the pilot
  final String startingHintMessage;

  ///[endingHintMessage] include information for the pilot
  final String endingHintMessage;

  ///[errorHintMessage] if you would like hintText to be shown after the answer has been given then include the hint text.
  final String errorHintMessage;

  ///[requiredFrequency] if shouldShowFrequencyPicker make sure the frequency matches required Frequency
  final double requiredFrequency;

  ///[requiredWords] if these words are not included in the transmission show the hint Text.
  final List<RequiredWord> requiredWords;

  ///[responseDelay] the number of seconds for the tower to respond
  final Duration responseDelay;

  ///[checkForPilotDialogueMatching] default = true; if false any message can be used.
  final bool checkForPilotDialogueMatching;

  ///[_player] for playing response audio files.
  final _player = AudioCache(fixedPlayer: AudioPlayer());

  /// responds appropriately to the [textToSpeechOutput] give from text to speech
  /// [onUndiscernableSpeech] is a callback that gives you the text that Failed
  /// [onFinished] is a callback that notifies the view when the next transmission should be played

  String get initialMessage {
    if (startingHintMessage != null) {
      return startingHintMessage;
    } else {
      return "Try Saying: ${pilotDialogue[0]}";
    }
  }

  void respondToPilotDialogue(
      {String textToSpeechOutput,
      Function(
        String failedText,
        double clarity,
      )
          onUndiscernableSpeech,
      Function(String) showHintBubble,
      Function(double) showFrequencyPicker,
      Function(bool) onFinished,
      Function(bool) onRequiredNotFound}) async {
    _player.fixedPlayer.stop();
    _checkForNullHint(
        callBackFunction: showHintBubble, message: initialMessage);

    if (checkForPilotDialogueMatching) {
      double checkResult = 0;
      pilotDialogue.forEach((element) {
        if (textToSpeechOutput.similarityTo(element) > checkResult) {
          checkResult = textToSpeechOutput.similarityTo(element);
        }
      });
      if (checkResult < 0.5 ||
          ((requiredWords != null) &&
              (!_requiredWordsIncluded(inString: textToSpeechOutput)))) {
        _playErrorMessage();
        _showPilotWhatToSay(showHintBubble);
        onFinished(false);
      } else {
        _playTowerResponseAndShowAppropriateDialogues(
            hintCallBack: showHintBubble,
            finishedCompetionHandler: onFinished,
            showFrequencyPicker: showFrequencyPicker);
      }
    }
  }

  void _playTowerResponseAndShowAppropriateDialogues(
      {Function(String) hintCallBack,
      Function(bool) finishedCompetionHandler,
      Function showFrequencyPicker}) {
    if (towerResponseSoundFileLocation != null) {
      _player.play(towerResponseSoundFileLocation);
    }
    _checkForNullFrequency(callBackFunction: showFrequencyPicker);
    _checkForNullHint(
        callBackFunction: hintCallBack, message: endingHintMessage);
    finishedCompetionHandler(true);
  }

  void _playErrorMessage() async {
    if (towerErrorResponseSoundFileLocation != null) {
      _player.play(towerErrorResponseSoundFileLocation);
    } else {
      _player.play(_sayAgainMessageLocation);
    }
  }

  void _showPilotWhatToSay(Function(String) showHintCallback) {
    _checkForNullHint(
        callBackFunction: showHintCallback,
        message: "try saying: ${pilotDialogue[0]}");
    _checkForNullHint(
        callBackFunction: showHintCallback, message: errorHintMessage);
  }

  void _checkForNullHint(
      {Function(String) callBackFunction, String message}) async {
    if (message != null) {
      callBackFunction(message);
      await Future.delayed(responseDelay);
    }
  }

  void _checkForNullFrequency({Function(double) callBackFunction}) {
    if (requiredFrequency != null) {
      callBackFunction(requiredFrequency);
    }
  }

  bool _requiredWordIncluded(RequiredWord word, String inString) {
    bool isIncluded = false;

    for (var each in word.wordPermutations) {
      if (inString.toLowerCase().contains(each.toLowerCase())) {
        return true;
      }
    }
    print("RequiredWord not found: ${word.wordPermutations[0]}");
    return isIncluded;
  }

  bool _requiredWordsIncluded({String inString}) {
    assert(requiredWords != null,
        "Error Tried to check for missing words but requiredWords == null");
    //all required words must be present
    //for each required word there must be at least one required word that is included.

    for (var requiredWord in requiredWords) {
      if (!_requiredWordIncluded(requiredWord, inString)) {
        return false;
      }
    }
    return true;
  }
}
// make stack of questions, with answers if they get it wrong promt them on what to say.

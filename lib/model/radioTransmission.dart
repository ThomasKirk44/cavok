import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cavok/model/requiredWord.dart';
import 'package:flutter/foundation.dart';
import 'package:string_similarity/string_similarity.dart';

/// This function is used to check if a list is null or empty.. this was a painful solution, cant believe there isnt something better to do this.. also used in RadioView
T exceptionAware<T>(T Function() f) {
  try {
    return f();
  } catch (_) {
    return null;
  }
}

class RadioTransmission {
  RadioTransmission({
    @required this.pilotDialogue,
    @required this.towerResponseSoundFileLocation,
    this.towerErrorResponseSoundFileLocation,
    this.errorHintMessage,
    this.requiredFrequency,
    this.requiredWords,
    this.responseDelay = const Duration(seconds: 4),
    this.hintMessage,
  });

  ///[pilotDialogue] questions can be asked in more than one way so a list is supplied of possible questions. to ensure the system understands what the person is trying to say.
  List<String> pilotDialogue;

  ///[towerResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerResponseSoundFileLocation;

  ///[towerErrorResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerErrorResponseSoundFileLocation;

  static final String _sayAgainMessageLocation =
      "tripAudio/generic/Say again.mp3";

  ///[hintMessage] include information for the pilot
  final String hintMessage;

  ///[errorHintMessage] if you would like hintText to be shown after the answer has been given then include the hint text.
  final String errorHintMessage;

  ///[requiredFrequency] if shouldShowFrequencyPicker make sure the frequency matches required Frequency
  final double requiredFrequency;

  ///[requiredWords] if these words are not included in the transmission show the hint Text.
  final List<RequiredWord> requiredWords;

  ///[responseDelay] the number of seconds for the tower to respond
  final Duration responseDelay;

  ///[checkForPilotDialogueMatching] default = true; if false any message can be used.
  bool get checkForPilotDialogueMatching {
    return _checkForPilotDialogueMatching;
  }

  /// [_checkForPilotDialogueMatching] this is used for change the value checkForPilotDialogueMatching.
  bool _checkForPilotDialogueMatching = true;

  ///[_player] for playing response audio files.
  static final _player = AudioCache(fixedPlayer: AudioPlayer());

  /// responds appropriately to the [textToSpeechOutput] give from text to speech
  /// [onUndiscernableSpeech] is a callback that gives you the text that Failed
  /// [onFinished] is a callback that notifies the view when the next transmission should be played

  String get initialMessage {
    if (exceptionAware(() => pilotDialogue[0]) == null) {
      _checkForPilotDialogueMatching = false;
      print("it worked yaaaaaa");
    }
    if (hintMessage != null) {
      return hintMessage;
    } else {
      if (checkForPilotDialogueMatching) {
        return pilotDialogue[0];
      } else {
        return "Try Saying Anything";
      }
    }
  }

  T firstOrNull<T>(List<T> list) {
    if (list.isEmpty) {
      return null;
    } else {
      return list.first;
    }
  }

  ///this function just makes sure that the frequency has 7 digits if it doesnt it inserts zeros to fill it in. ex 124 == 124.000, 123.44 == 123.440
  void frequencyValidator() {}

  void disposeAudioPlayer() async {
    await _player.fixedPlayer.dispose();
  }

  void respondToPilotDialogue(
      {String textToSpeechOutput,
      Function(
        String failedText,
        double clarity,
      )
          onUndiscernableSpeech,
      Function(String) showErrorHintBubble,
      Function(double) showFrequencyPicker,
      Function(bool) onFinished,
      Function(bool) onRequiredNotFound}) async {
    if (pilotDialogue == null) {
      _checkForPilotDialogueMatching = false;
    }

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
        _showPilotWhatToSay(showErrorHintBubble);
        onFinished(false);
      } else {
        _playTowerResponseAndShowPicker(
            hintCallBack: showErrorHintBubble,
            finishedCompetionHandler: onFinished,
            showFrequencyPicker: showFrequencyPicker);
      }
    } else {
      //this is the case that it doesn't matter what the pilot says it is just supposed to play the message
      _playTowerResponseAndShowPicker(
          hintCallBack: showErrorHintBubble,
          finishedCompetionHandler: onFinished,
          showFrequencyPicker: showFrequencyPicker);
    }
  }

  void _playTowerResponseAndShowPicker(
      {Function(String) hintCallBack,
      Function(bool) finishedCompetionHandler,
      Function showFrequencyPicker}) {
    _player.fixedPlayer = AudioPlayer();
    if (towerResponseSoundFileLocation != null) {
      _player.play(towerResponseSoundFileLocation);
    }
    _checkForNullFrequency(callBackFunction: showFrequencyPicker);
    finishedCompetionHandler(true);
  }

  void _playErrorMessage() async {
    _player.fixedPlayer = AudioPlayer();
    if (towerErrorResponseSoundFileLocation != null) {
      _player.play(towerErrorResponseSoundFileLocation);
    } else {
      _player.play(_sayAgainMessageLocation);
    }
  }

  void _showPilotWhatToSay(Function(String) showHintCallback) {
    if (errorHintMessage == null) {
      _checkForNullHint(
          callBackFunction: showHintCallback,
          message: "try saying: ${pilotDialogue[0]}");
    } else {
      _checkForNullHint(
          callBackFunction: showHintCallback, message: errorHintMessage);
    }
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

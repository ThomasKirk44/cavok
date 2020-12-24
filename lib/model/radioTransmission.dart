import 'package:cavok/model/requiredWord.dart';
import 'package:flutter/foundation.dart';

class RadioTransmission {
  RadioTransmission(
      {@required this.pilotDialogue,
      @required this.towerResponseSoundFileLocation,
      this.towerErrorResponseSoundFileLocation,
      this.hintText,
      this.showFrequencyPicker = false,
      this.requiredFrequency,
      this.requiredWords,
      this.responseDelay = const Duration(seconds: 2),
      this.repeatPreviousMessageOnError,
      this.checkForPilotDialogueMatching = true});

  ///[pilotDialogue] questions can be asked in more than one way so a list is supplied of possible questions. to ensure the system understands what the person is trying to say.
  final List<String> pilotDialogue;

  ///[towerResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerResponseSoundFileLocation;

  ///[towerErrorResponseSoundFileLocation] the location of the answer mp3 file to be played in response to the question. ex.. "tripAudio/newcastle-welshpool/3.mp3" the text should not include the assets folder.
  final String towerErrorResponseSoundFileLocation;

  ///[hintText] if you would like hintText to be shown after the answer has been given then include the hint text.
  final String hintText;

  ///[showFrequencyPicker] determines whether the FrequencyPicker is shown after the answer.
  final bool showFrequencyPicker;

  ///[requiredFrequency] if shouldShowFrequencyPicker make sure the frequency matches required Frequency
  final double requiredFrequency;

  ///[requiredWords] if these words are not included in the transmission show the hint Text.
  final List<RequiredWord> requiredWords;

  ///[responseDelay] the number of seconds for the tower to respond
  final Duration responseDelay;

  ///[repeatPreviousMessageOnError] bool repeats the previous message if the required word's arent found
  final bool repeatPreviousMessageOnError;

  ///[checkForPilotDialogueMatching] default = true; if false any message can be used.
  final bool checkForPilotDialogueMatching;
}
// make stack of questions, with answers if they get it wrong promt them on what to say.

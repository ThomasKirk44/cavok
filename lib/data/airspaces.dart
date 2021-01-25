import 'package:cavok/model/airspace.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:cavok/model/requiredWord.dart';

class AirSpaceNames {
  static final String london = "london";
  static final String shawbury = "shawbury";
}

final Map<String, AirSpace> airSpaces = {
  AirSpaceNames.london:
      AirSpace(name: "london", radioFrequency: 118.505, conversation: [
    RadioTransmission(
        pilotDialogue: ["Basic service Golf Charlie Delta"],
        errorHintMessage:
            "You are now leaving Newcastle’s ATZ and need to contact London information 124.750 for a basic service"),
    RadioTransmission(
        requiredFrequency: 124.750,
        requiredWords: [
          RequiredWord(wordPermutations: ["information"])
        ],
        pilotDialogue: [
          "Newcastle Radar Golf Alpha Bravo Charlie Delta request frequency change to london information 124.750"
        ],
        towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/10.mp3"),
    RadioTransmission(pilotDialogue: [
      " London Information Golf Alpha Bravo Charlie Delta Request basic service"
    ], towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/11.mp3"),
    RadioTransmission(
        towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/11.mp3",
        checkForPilotDialogueMatching: false)
  ]),
  AirSpaceNames.shawbury:
      AirSpace(name: "shawbury", radioFrequency: 133.15, conversation: [
    RadioTransmission(
        requiredWords: [
          RequiredWord(wordPermutations: ["1177"])
        ],
        pilotDialogue: [
          "Squawk 1177 with charlie, Golf Alpha Bravo Charlie Delta"
        ],
        responseDelay: Duration(seconds: 5),
        errorHintMessage:
            "You are now 5 miles from the Shawbury zone military air traffic zone boundary and require a ‘MATZ’ penetration. Change to shawbury zone 133.150"),
    RadioTransmission(requiredWords: [
      RequiredWord(wordPermutations: ["133.150"])
    ], pilotDialogue: [
      " London information Golf Alpha Bravo Charlie Delta request frequency change to shawbury zone 133.150"
    ], towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/12.mp3"),
    RadioTransmission(
      pilotDialogue: ["squawk 7000 Golf Charlie Delta"],
      requiredFrequency: 133.15,
    ),
    RadioTransmission(requiredWords: [
      RequiredWord(wordPermutations: ["basic Service"])
    ], pilotDialogue: [
      "Shawbury zone GABCD request basic service and max penetration"
    ], towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/13.mp3"),
    RadioTransmission(
        pilotDialogue: [],
        towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/14.mp3",
        checkForPilotDialogueMatching: false),
    RadioTransmission(requiredWords: [
      RequiredWord(
          wordPermutations: ["not below 2000", "not below two thousand"])
    ], pilotDialogue: [
      "Max penetration approved not below 2000 feet report entering and leaving the zone Golf Charlie Delta",
      "Matz penetration approved not below 2000 feet report entering and leaving the zone Golf Charlie Delta"
    ], errorHintMessage: "You are entering Shawbury Zone"),
    RadioTransmission(
        pilotDialogue: [],
        errorHintMessage: "You are leaving Shawbury Zone",
        responseDelay: Duration(seconds: 5)),
  ])
};

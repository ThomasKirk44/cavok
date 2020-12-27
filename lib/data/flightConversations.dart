import 'package:cavok/data/airports.dart';
import 'package:cavok/model/airspace.dart';
import 'package:cavok/model/flight.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:cavok/model/requiredWord.dart';

final Flight newCastleToWelshpool = Flight(
    startingAirport: Airports().getAirport("EGNT"),
    endingAirport: Airports().getAirport("EGCW"),
    airspace: [
      AirSpace(name: "Shawburry", radioFrequency: 122.10),
      AirSpace(name: "London", radioFrequency: 119.40)
    ],
    flightConversation: [
      RadioTransmission(
          pilotDialogue: [
            "‘Newcastle ground, GABCD, at golf apron, information Yankee, QNH 1013, request engine start’."
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/1.mp3",
          errorHintText: "Hint: Request Engine Start?"),
      RadioTransmission(
          pilotDialogue: [
            "‘Newcastle ground, GABCD, at golf apron, information Yankee, QNH 1013, request engine start’."
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/2.mp3",
          errorHintText: "Hint: Request Engine Start?"),
      RadioTransmission(pilotDialogue: [
        "start at time 34 Golf Alpha Bravo Charlie Delta.",
        "start approved Golf Alpha Bravo Charlie Delta"
      ], errorHintText: "Hint: Say back what you heard the tower say."),
      RadioTransmission(
          pilotDialogue: [
            "‘Newcastle ground, Golf Alpha Bravo Charlie Delta, at golf apron, request taxi"
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/3.mp3",
          errorHintText: "Hint: Request Taxi"),
      RadioTransmission(
          requiredFrequency: 119.70,
          requiredWords: [
            RequiredWord(wordPermutations: ["golf"]),
            RequiredWord(wordPermutations: ["119.70"]),
            RequiredWord(wordPermutations: ["two five"])
          ],
          pilotDialogue: [
            "Taxi holding point golf runway 25, contact newcastle tower 119.70"
          ],
          errorHintText: "Hint: Confirm you heard tower correctly?"),
      RadioTransmission(
          pilotDialogue: [
            "Newcastle tower Golf Alpha Bravo Charlie Delta at holding point golf"
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/4.mp3",
          errorHintText: "Hint: Contact Newcastle Tower?"),
      RadioTransmission(requiredWords: [
        RequiredWord(wordPermutations: ["two five", "25"])
      ], pilotDialogue: [
        "Line up runway 25 Golf Alpha Bravo Charlie Delta"
      ], towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/5.mp3"),
      RadioTransmission(
        requiredWords: [
          RequiredWord(wordPermutations: [
            "tyne bridges",
            "tine bridges",
            "tine bridge"
          ]),
          RequiredWord(wordPermutations: ["6522"]),
          RequiredWord(wordPermutations: ["1013"])
        ],
        pilotDialogue: [
          "after departure cleared to zone boundary via tyne bridges. not above altitude 2500 feet QNH 1013, squawk 6522"
        ],
        towerErrorResponseSoundFileLocation:
            "tripAudio/newcastle-welshpool/7.mp3",
        towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/6.mp3",
      ),
      RadioTransmission(
          pilotDialogue: ["Cleared for takeoff Golf Alpha Bravo Charlie Delta"],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/8.mp3",
          responseDelay: Duration(seconds: 5)),
      RadioTransmission(
        requiredFrequency: 124.375,
        pilotDialogue: [
          " Contact newcastle radar 124.375 Golf Alpha Bravo Charlie Delta"
        ],
      ),
      RadioTransmission(requiredWords: [
        RequiredWord(wordPermutations: ["radar"])
      ], pilotDialogue: [
        "Newcastle radar Golf Alpha Bravo Charlie Delta"
      ], towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/9.mp3"),
      RadioTransmission(
          pilotDialogue: ["Basic service Golf Charlie Delta"],
          errorHintText:
              "You are now leaving Newcastle’s ATZ and need to contact London information 124.750 for a basic service"),
      RadioTransmission(
          requiredFrequency: 124.750,
          requiredWords: [
            RequiredWord(wordPermutations: ["information"])
          ],
          pilotDialogue: [
            "Newcastle Radar Golf Alpha Bravo Charlie Delta request frequency change to london information 124.750"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/10.mp3"),
      RadioTransmission(
          pilotDialogue: [
            " London Information Golf Alpha Bravo Charlie Delta Request basic service"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/11.mp3"),
      RadioTransmission(
          pilotDialogue: [],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/11.mp3",
          checkForPilotDialogueMatching: false),
      RadioTransmission(
          requiredWords: [
            RequiredWord(wordPermutations: ["1177"])
          ],
          pilotDialogue: [
            "Squawk 1177 with charlie, Golf Alpha Bravo Charlie Delta"
          ],
          responseDelay: Duration(seconds: 5),
          errorHintText:
              "You are now 5 miles from the Shawbury zone military air traffic zone boundary and require a ‘MATZ’ penetration. Change to shawbury zone 133.150"),
      RadioTransmission(
          requiredWords: [
            RequiredWord(wordPermutations: ["133.150"])
          ],
          pilotDialogue: [
            " London information Golf Alpha Bravo Charlie Delta request frequency change to shawbury zone 133.150"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/12.mp3"),
      RadioTransmission(
        pilotDialogue: ["squawk 7000 Golf Charlie Delta"],
        requiredFrequency: 133.15,
      ),
      RadioTransmission(
          requiredWords: [
            RequiredWord(wordPermutations: ["basic Service"])
          ],
          pilotDialogue: [
            "Shawbury zone GABCD request basic service and max penetration"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/13.mp3"),
      RadioTransmission(
          pilotDialogue: [],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/14.mp3",
          checkForPilotDialogueMatching: false),
      RadioTransmission(requiredWords: [
        RequiredWord(
            wordPermutations: ["not below 2000", "not below two thousand"])
      ], pilotDialogue: [
        "Max penetration approved not below 2000 feet report entering and leaving the zone Golf Charlie Delta",
        "Matz penetration approved not below 2000 feet report entering and leaving the zone Golf Charlie Delta"
      ], errorHintText: "You are entering Shawbury Zone"),
      RadioTransmission(
          pilotDialogue: [],
          errorHintText: "You are leaving Shawbury Zone",
          responseDelay: Duration(seconds: 5)),
      RadioTransmission(
          pilotDialogue: [],
          errorHintText:
              " You are 5 miles to the north of Welshpool and should change to Welshpool radio 128.005",
          responseDelay: Duration(seconds: 5)),
      RadioTransmission(
          requiredFrequency: 128.005,
          pilotDialogue: [
            " Golf Charlie Delta is 5 miles to the north of Welshpool and is changing to 128.005"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/15.mp3"),
      RadioTransmission(
        requiredWords: [
          RequiredWord(wordPermutations: ["welshpool"])
        ],
        pilotDialogue: [
          " Welshpool radio GABCD is 5 miles to the north and request joining information"
        ],
        towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/16.mp3",
      ),
      RadioTransmission(
          requiredWords: [
            RequiredWord(wordPermutations: ["22", "two two"])
          ],
          pilotDialogue: [
            " QNH 1011 runway two two GCD"
                " QNH 1011 runway 22 GCD"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/17.mp3",
          towerErrorResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/16.mp3",
          errorHintText: "You are on finals for runway 22"),
      RadioTransmission(
          pilotDialogue: [
            "Golf Charlie Delta finals 22"
                "Golf Charlie Delta final 22"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/18.mp3",
          errorHintText: "You have landed at Welshpool, Flight complete!!")
    ]);

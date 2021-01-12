import 'package:cavok/main.dart';
import 'package:cavok/model/airport.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:cavok/model/requiredWord.dart';

import 'airspaces.dart';

///anytime you want to add a new airport first add the airport to the availableAirports list. as the others where below.
///next add the airport object below
final List<String> availableAirportNames = [
  airportIcaoName["EGNT"],
  airportIcaoName["EGCW"]
];

///Map<Icao,Name>
Map<String, String> airportNameIcao = {
  airportIcaoName["EGNT"]: "EGNT",
  airportIcaoName["EGCW"]: "EGCW"
};

///include all the properties and conversations last for readability.
final Map<String, Airport> airports = {
  "EGNT": Airport(
      availableAirspaces: [AirSpaceNames.london, AirSpaceNames.shawbury],
      fromIcaoCode: "EGNT",
      towerFrequency: 119.70,
      endingAirportConversation: [
        RadioTransmission(
            pilotDialogue: [
              "‘Newcastle ground, GABCD, at golf apron, information Yankee, QNH 1013, request engine start’."
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/1.mp3",
            errorHintText: "Hint: Request Engine Start?"),
        RadioTransmission(
            pilotDialogue: [
              "‘Newcastle ground, GABCD, at golf apron, information Yankee, QNH 1013, request engine start’."
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/2.mp3",
            errorHintText: "Hint: Request Engine Start?"),
        RadioTransmission(pilotDialogue: [
          "start at time 34 Golf Alpha Bravo Charlie Delta.",
          "start approved Golf Alpha Bravo Charlie Delta"
        ], errorHintText: "Hint: Say back what you heard the tower say."),
        RadioTransmission(
            pilotDialogue: [
              "‘Newcastle ground, Golf Alpha Bravo Charlie Delta, at golf apron, request taxi"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/3.mp3",
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
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/4.mp3",
            errorHintText: "Hint: Contact Newcastle Tower?"),
        RadioTransmission(
            requiredWords: [
              RequiredWord(wordPermutations: ["two five", "25"])
            ],
            pilotDialogue: [
              "Line up runway 25 Golf Alpha Bravo Charlie Delta"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/5.mp3"),
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
            pilotDialogue: [
              "Cleared for takeoff Golf Alpha Bravo Charlie Delta"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/8.mp3",
            responseDelay: Duration(seconds: 5)),
        RadioTransmission(
          requiredFrequency: 124.375,
          pilotDialogue: [
            " Contact newcastle radar 124.375 Golf Alpha Bravo Charlie Delta"
          ],
        ),
        RadioTransmission(
            requiredWords: [
              RequiredWord(wordPermutations: ["radar"])
            ],
            pilotDialogue: [
              "Newcastle radar Golf Alpha Bravo Charlie Delta"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/9.mp3"),
      ]),
  "EGCW": Airport(
      fromIcaoCode: "EGCW",
      towerFrequency: 128.00,
      availableAirspaces: [
        AirSpaceNames.london,
        AirSpaceNames.shawbury
      ],
      startingAirportConversation: [
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
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/16.mp3",
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
            errorHintText: "You have landed at Welshpool, Flight complete!!"),
      ])
};

import 'package:cavok/main.dart';
import 'package:cavok/model/airport.dart';
import 'package:cavok/model/radioTransmission.dart';
import 'package:cavok/model/requiredWord.dart';

import 'airspaces.dart';

///anytime you want to add a new airport first add the airport to the availableAirports list. as the others where below.
///next add the airport object below
final List<String> availableAirportNames = [
  airportIcaoName["EGNT"], //newcastle
  airportIcaoName["EGCW"], //welshpool
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
    startingAirportConversation: [
      RadioTransmission(
          startingHintMessage:
              "You are at the Newcastle airport request engine start.",
          pilotDialogue: [
            "‘Newcastle ground, GABCD, at golf apron, information Yankee, QNH 1013, request engine start’."
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/1.mp3",
          errorHintMessage: "Hint: Request Engine Start?"),
      RadioTransmission(pilotDialogue: [
        "start at time 34 Golf Alpha Bravo Charlie Delta.",
        "start approved Golf Alpha Bravo Charlie Delta"
      ], errorHintMessage: "Hint: Say back what you heard the tower say."),
      RadioTransmission(
          pilotDialogue: [
            "‘Newcastle ground, Golf Alpha Bravo Charlie Delta, at golf apron, request taxi"
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/3.mp3",
          errorHintMessage: "Hint: Request Taxi"),
      RadioTransmission(
          requiredFrequency: 119.70,
          requiredWords: [
            RequiredWord(wordPermutations: ["golf"]),
            RequiredWord(wordPermutations: ["119.70", "11970"]),
            RequiredWord(wordPermutations: ["two five", "25"])
          ],
          pilotDialogue: [
            "Taxi holding point golf runway 25, contact newcastle tower 119.70"
          ],
          errorHintMessage: "Hint: Confirm you heard tower correctly?"),
      RadioTransmission(
          pilotDialogue: [
            "Newcastle tower Golf Alpha Bravo Charlie Delta at holding point golf"
          ],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/4.mp3",
          errorHintMessage: "Hint: Contact Newcastle Tower?"),
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
          "Contact newcastle radar 124.375 Golf Alpha Bravo Charlie Delta"
        ],
      ),
      RadioTransmission(requiredWords: [
        RequiredWord(wordPermutations: ["radar"])
      ], pilotDialogue: [
        "Newcastle radar Golf Alpha Bravo Charlie Delta"
      ], towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/9.mp3"),
    ],
    endingAirportConversation: [
      RadioTransmission(
          pilotDialogue: ["request frequency change to 124.375"],
          towerResponseSoundFileLocation: "tripAudio/newcastle-welshpool/9.mp3",
          errorHintMessage: "Correct Frequency?"),
      RadioTransmission(
          pilotDialogue: [
            "Newcastle approach 124.375 squawk 7000"
          ],
          requiredWords: [
            RequiredWord(wordPermutations: [
              "one two four dot three seven five",
              "124.375"
            ]),
            RequiredWord(wordPermutations: ["seven thousand", "7000"])
          ],
          requiredFrequency: 124.375,
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/10.mp3",
          endingHintMessage:
              "Enter Frequency and then get basic service to figure out joining instructions. you are 10 miles south of newcastle at 2000ft"),
      RadioTransmission(
          pilotDialogue: [
            "Newcastle approach golf alpha bravo charlie delta request basic service and joining instructions"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/11.mp3"),
      RadioTransmission(
          checkForPilotDialogueMatching: false,
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/12.mp3"),
      RadioTransmission(
          pilotDialogue: [
            "cleared to join right base runway 25 via the tyne bridges, report overhead tyne bridges, golf alpha bravo charlie delta "
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/13.mp3",
          startingHintMessage: "You are overhead the tyne bridges"),
      RadioTransmission(
          pilotDialogue: [
            "golf alpha bravo charlie delta overhead tyne bridges"
          ],
          requiredWords: [
            RequiredWord(wordPermutations: ["bridge", "bridges"])
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/14.mp3"),
      RadioTransmission(
          pilotDialogue: [
            "Contact Newcastle Tower one one niner seven zero",
            "contact newcastle tower one one nine seven zero"
          ],
          requiredFrequency: 119.70,
          endingHintMessage:
              "you are positioned for right base runway two five"),
      RadioTransmission(
          pilotDialogue: [
            "newcastle tower golf alpha bravo charlie delta possitioning for right base runway two five"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/15.mp3"),
      RadioTransmission(pilotDialogue: [
        "Join right base runway two five quebec november hotel 1011 golf alpha bravo charlie delta"
      ], endingHintMessage: "You are on right base runway two five to land"),
      RadioTransmission(
          pilotDialogue: [
            "golf alpha bravo charlie delta right base runway two five to land"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/16.mp3"),
      RadioTransmission(
          pilotDialogue: ["golf alpha bravo charlie delta final two five"],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/17.mp3",
          startingHintMessage: "You are on final for runway two five"),
      RadioTransmission(
          pilotDialogue: [
            "golf alpha bravo charlie delta request taxi to golf alpha Apron"
          ],
          towerResponseSoundFileLocation:
              "tripAudio/newcastle-welshpool/18.mp3",
          startingHintMessage:
              "You have landed and need to request a taxi to GA apron"),
      RadioTransmission(startingHintMessage: "Flight Complete")
    ],
  ),
  "EGCW": Airport(
      fromIcaoCode: "EGCW",
      towerFrequency: 128.00,
      availableAirspaces: [
        AirSpaceNames.london,
        AirSpaceNames.shawbury
      ],
      endingAirportConversation: [
        RadioTransmission(
            pilotDialogue: [],
            errorHintMessage:
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
            errorHintMessage: "You are on finals for runway 22"),
        RadioTransmission(
            pilotDialogue: [
              "Golf Charlie Delta finals 22"
                  "Golf Charlie Delta final 22"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/newcastle-welshpool/18.mp3",
            errorHintMessage:
                "You have landed at Welshpool, Flight complete!!"),
      ],
      startingAirportConversation: [
        RadioTransmission(
            pilotDialogue: [
              "Welshpool radio golf alpha bravo charlie delta request radio check and airfield information",
              "Welshpool radio golf alpha bravo charlie delta request airfield information and radio check"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/welshpool-newcastle/1.mp3",
            startingHintMessage:
                "You are on the south apron at Welshpool airport and are about to start up, taxi to line up, and depart"),
        RadioTransmission(
            pilotDialogue: [
              "Runway two two quebec november hotel 1011",
              "runway 22 quebec november hotel one zero one one"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/welshpool-newcastle/2.mp3",
            requiredWords: [
              RequiredWord(wordPermutations: ["22", "two two"]),
              RequiredWord(wordPermutations: ["QNH", "quebec november hotel"]),
            ]),
        RadioTransmission(
            pilotDialogue: [
              "Runway two two quebec november hotel 1011",
              "runway 22 quebec november hotel one zero one one",
              "Golf Alpha Bravo Charlie Delta Taxiing to lineup two two via holding point Alpha"
            ],
            towerResponseSoundFileLocation:
                "tripAudio/welshpool-newcastle/3.mp3"),
        RadioTransmission(
            pilotDialogue: ["Golf Alpha Bravo Charlie Delta lining up two two"],
            towerResponseSoundFileLocation:
                "tripAudio/welshpool-newcastle/3.mp3"),
        RadioTransmission(
            pilotDialogue: ["Golf Alpha Bravo Charlie Delta departing two two"],
            towerResponseSoundFileLocation:
                "tripAudio/welshpool-newcastle/4.mp3"),
      ])
};

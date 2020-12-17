import 'package:cavok/model/airport.dart';
import 'package:cavok/model/question.dart';

class RadioController {
  RadioController();

  Airport currentAirport;

  ///[script] this list defines how the controller will respond to audio input.
  Map<Question, String> script;

  String askQuestion(Question question) {
    if (question.questionClearness < 0.8)
      return ("Sorry I didnt get that can you please repeat?");
  }
}

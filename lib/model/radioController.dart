import 'package:cavok/model/question.dart';

class RadioController {
  RadioController();

  String currentAirport;

  ///[script] this list defines how the controller will respond to audio input.
  Map<Question, String> script;
}

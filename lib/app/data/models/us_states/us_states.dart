import 'dart:convert';

UsStates usStatesFromJson(String str) => UsStates.fromJson(json.decode(str));
String usStatesToJson(UsStates data) => json.encode(data.toJson());

class UsStates {
  List<State> states;

  UsStates({
    required this.states,
  });

  factory UsStates.fromJson(Map<String, dynamic> json) => UsStates(
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class State {
  String name;
  String dmvManualLink;
  String abbreviation;
  int numberOfQuestions;
  int passingScore;

  State({
    required this.name,
    required this.dmvManualLink,
    required this.abbreviation,
    required this.numberOfQuestions,
    required this.passingScore,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        name: json["name"],
        dmvManualLink: json["dmvManualLink"],
        abbreviation: json["abbreviation"],
        numberOfQuestions: json["number_of_questions"],
        passingScore: json["passing_score"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dmvManualLink": dmvManualLink,
        "abbreviation": abbreviation,
        "number_of_questions": numberOfQuestions,
        "passing_score": passingScore,
      };
}

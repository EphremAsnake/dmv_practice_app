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
    int id;
    String name;
    String dmvManualLink;
    String abbreviation;

    State({
        required this.id,
        required this.name,
        required this.dmvManualLink,
        required this.abbreviation,
    });

    factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        dmvManualLink: json["dmvManualLink"],
        abbreviation: json["abbreviation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dmvManualLink": dmvManualLink,
        "abbreviation": abbreviation,
    };
}

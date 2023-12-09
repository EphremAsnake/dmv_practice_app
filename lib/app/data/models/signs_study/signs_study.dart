import 'dart:convert';

SignsStudy signsStudyFromJson(String str) => SignsStudy.fromJson(json.decode(str));

String signsStudyToJson(SignsStudy data) => json.encode(data.toJson());

class SignsStudy {
    SignsStudyClass signsStudy;

    SignsStudy({
        required this.signsStudy,
    });

    factory SignsStudy.fromJson(Map<String, dynamic> json) => SignsStudy(
        signsStudy: SignsStudyClass.fromJson(json["signs_study"]),
    );

    Map<String, dynamic> toJson() => {
        "signs_study": signsStudy.toJson(),
    };
}

class SignsStudyClass {
    List<SignsAndDescription> signsAndDescriptions;

    SignsStudyClass({
        required this.signsAndDescriptions,
    });

    factory SignsStudyClass.fromJson(Map<String, dynamic> json) => SignsStudyClass(
        signsAndDescriptions: List<SignsAndDescription>.from(json["signs_and_descriptions"].map((x) => SignsAndDescription.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "signs_and_descriptions": List<dynamic>.from(signsAndDescriptions.map((x) => x.toJson())),
    };
}

class SignsAndDescription {
    String image;
    String name;
    String description;

    SignsAndDescription({
        required this.image,
        required this.name,
        required this.description,
    });

    factory SignsAndDescription.fromJson(Map<String, dynamic> json) => SignsAndDescription(
        image: json["image"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "description": description,
    };
}

import 'dart:convert';

Tests testsFromJson(String str) => Tests.fromJson(json.decode(str));

String testsToJson(Tests data) => json.encode(data.toJson());

class Tests {
  int id;
  int numberOfQuestions;
  int passingScore;
  List<Question> questions;

  Tests({
    required this.id,
    required this.numberOfQuestions,
    required this.passingScore,
    required this.questions,
  });

  factory Tests.fromJson(Map<String, dynamic> json) => Tests(
        id: json["id"],
        numberOfQuestions: json["number_of_questions"],
        passingScore: json["passing_score"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number_of_questions": numberOfQuestions,
        "passing_score": passingScore,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  int id;
  String question;
  String? imageUrl;
  int answerId;
  String explaniation;
  List<Choice> choices;

  Question({
    required this.id,
    required this.question,
    this.imageUrl,
    required this.answerId,
    required this.explaniation,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id:json["id"],
        question: json["question"],
        imageUrl: json["image_url"],
        answerId: json["answer_id"],
        explaniation: json["explaniation"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image_url": imageUrl,
        "answer_id": answerId,
        "explaniation": explaniation,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
      };
}

class Choice {
  int id;
  String text;
  bool status;
  bool selected;

  Choice({
    required this.id,
    required this.text,
    required this.status,
    this.selected = false,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        text: json["text"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "status": status,
      };
}

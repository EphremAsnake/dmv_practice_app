import 'dart:convert';

Test testsFromJson(String str) => Test.fromJson(json.decode(str));

String testsToJson(Test data) => json.encode(data.toJson());

class Test {
  int id;
  List<Question> questions;

  Test({
    required this.id,
    required this.questions,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  int id;
  String question;
  String? imageUrl;
  int answerId;
  String? explanation;
  List<Choice> choices;

  Question({
    required this.id,
    required this.question,
    this.imageUrl,
    required this.answerId,
    this.explanation,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        imageUrl: json["image_url"],
        answerId: json["answer_id"],
        explanation: json["explaniation"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image_url": imageUrl,
        "answer_id": answerId,
        "explaniation": explanation,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
      };
}

class Choice {
  int id;
  String text;
  bool selected;

  Choice({
    required this.id,
    required this.text,
    this.selected = false,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}

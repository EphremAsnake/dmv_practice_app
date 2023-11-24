import 'dart:convert';

AllTests allTestsFromJson(String str) => AllTests.fromJson(json.decode(str));

String allTestsToJson(AllTests data) => json.encode(data.toJson());

class AllTests {
    List<Test> tests;

    AllTests({
        required this.tests,
    });

    factory AllTests.fromJson(Map<String, dynamic> json) => AllTests(
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
    };
}

class Test {
    int id;
    String name;
    String url;

    Test({
        required this.id,
        required this.name,
        required this.url,
    });

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
    };
}

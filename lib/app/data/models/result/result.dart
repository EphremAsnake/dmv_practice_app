import 'dart:convert';
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Result {
  int id;
  bool isCorrect;
  int selectedAnswerId;
  Result({
    required this.id,
    required this.isCorrect,
    required this.selectedAnswerId,
  });

  Result copyWith({
    int? id,
    bool? isCorrect,
    int? selectedAnswerId,
  }) {
    return Result(
      id: id ?? this.id,
      isCorrect: isCorrect ?? this.isCorrect,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isCorrect': isCorrect,
      'selectedAnswerId': selectedAnswerId,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'] as int,
      isCorrect: map['isCorrect'] as bool,
      selectedAnswerId: map['selectedAnswerId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Result(id: $id, isCorrect: $isCorrect, selectedAnswerId: $selectedAnswerId)';

  @override
  bool operator ==(covariant Result other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.isCorrect == isCorrect &&
      other.selectedAnswerId == selectedAnswerId;
  }

  @override
  int get hashCode => id.hashCode ^ isCorrect.hashCode ^ selectedAnswerId.hashCode;
}

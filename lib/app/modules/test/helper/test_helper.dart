import 'package:drivingexam/app/data/models/result/result.dart';
import 'package:flutter/material.dart';

class TestHelper {
  Color getBorderColor(bool isAnswerSelected, bool isChoiceSelected,
      bool wasAnswerdCorrectly, int choiceId, int answerId) {
    Color borderColor;
    if (isAnswerSelected) {
      if (isChoiceSelected) {
        borderColor =
            wasAnswerdCorrectly ? const Color(0xFF016A70) : Colors.red;
      } else {
        borderColor = answerId == choiceId
            ? const Color(0xFF016A70)
            : const Color.fromARGB(255, 216, 216, 216);
      }
    } else {
      borderColor = isChoiceSelected
          ? const Color(0xFF016A70)
          : const Color.fromARGB(255, 216, 216, 216);
    }
    return borderColor;
  }

  int countErrorsFromResult(List<Result> result) {
    int errors = result.where((element) => element.isCorrect == false).toList().length;
    return errors;
  }

  int countCorrectAnswersFromResult(List<Result> result) {
    int errors = result.where((element) => element.isCorrect == true).toList().length;
    
    return errors;
  }
}

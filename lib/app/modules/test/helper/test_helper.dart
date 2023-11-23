import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/data/models/result/result.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestHelper {
  final themeData = Get.find<ThemeController>().themeData.value;
  final usStateController = Get.find<UsStatesController>();
  Color getBorderColor(bool isAnswerSelected, bool isChoiceSelected,
      bool wasAnswerdCorrectly, int choiceId, int answerId) {
    Color borderColor;
    if (isAnswerSelected) {
      if (isChoiceSelected) {
        borderColor = wasAnswerdCorrectly
            ? themeData!.primaryColor
            : themeData!.errorColor;
      } else {
        borderColor = answerId == choiceId
            ? themeData!.primaryColor
            : themeData!.grayTextColor;
      }
    } else {
      borderColor =
          isChoiceSelected ? themeData!.primaryColor : themeData!.grayTextColor;
    }
    return borderColor;
  }

  int countErrorsFromResult(List<Result> result) {
    int errors =
        result.where((element) => element.isCorrect == false).toList().length;
    return errors;
  }

  int countCorrectAnswersFromResult(List<Result> result) {
    int errors =
        result.where((element) => element.isCorrect == true).toList().length;

    return errors;
  }

  bool passedOrFailed(List<Result> result) {
    int correctAnswers = countCorrectAnswersFromResult(result);
    if (correctAnswers > (usStateController.state?.passingScore ?? 0)) {
      return true;
    } else {
      return false;
    }
  }

  Icon? getCheckedOrWrongIcon(bool isAnswerSelected, bool isChoiceSelected,
      bool wasAnswerdCorrectly, int choiceId, int answerId) {
    Icon? icon;
    if (isAnswerSelected) {
      if (isChoiceSelected) {
        icon = wasAnswerdCorrectly
            ? Icon(Icons.check, color: themeData?.whiteColor)
            : Icon(Icons.close, color: themeData?.whiteColor);
      } else {
        icon = answerId == choiceId
            ? Icon(Icons.check, color: themeData?.whiteColor)
            : null;
      }
      return icon;
    }
    return null;
  }
}

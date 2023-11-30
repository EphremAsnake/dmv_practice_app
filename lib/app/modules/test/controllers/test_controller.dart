import 'dart:convert';
import 'package:confetti/confetti.dart';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/data/models/result/result.dart';
import 'package:drivingexam/app/data/models/test/test.dart';
import 'package:drivingexam/app/modules/test/controllers/test_http_attribuites.dart';
import 'package:drivingexam/app/modules/test/helper/test_helper.dart';
import 'package:drivingexam/app/modules/test/views/result_page.dart';
import 'package:drivingexam/app/utils/helper/Interstitial_ad_manager.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  var currentPageIndex = 0.obs;
  int choiceId = 0;
  Rx<bool> isAnswerSelected = false.obs;
  Test? test;
  Rx<bool> wasAnsweredCorrectly = false.obs;
  Rx<bool> isSelectingAnswerEnabled = true.obs;
  Rx<bool> showAnswer = true.obs;
  late ConfettiController confettiController;
  Rx<bool> showProgress = false.obs;
  List<Result> results = <Result>[].obs;
  Rx<int> questionPageNumber = 1.obs;
  Rx<bool> showDescription = false.obs;
  TestHelper testHelper = TestHelper();
  String testUrl;
  Rx<int> showAdCounter = 0.obs;
  Rx<bool> isLastQuestionPageBackButtonEnabled = false.obs;
  Question? question;
  int numberOfQuestionsForState = 0;
  ScrollController scrollController = ScrollController();
  
  TestController(this.testUrl, this.numberOfQuestionsForState);

  final apiStateHandler = ApiStateHandler<Test>();
  var httpService = Get.find<HttpService>();

  @override
  void onInit() {
    fetchData();
    confettiController = ConfettiController();
    InterstitialAdManager().loadAd();
    super.onInit();
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

  void playConfetti() {
    confettiController.play();
  }

  void nextPage() => currentPageIndex.value++;
  void previousPage() => currentPageIndex.value--;

  void fetchData() async {
    apiStateHandler.setLoading();
    try {
      TestHttpAttributes testHttpAttributes = TestHttpAttributes();
      testHttpAttributes.url = testUrl;
      dynamic response = await httpService.sendHttpRequest(testHttpAttributes);

      final result = jsonDecode(response.body);
      test = Test.fromJson(result);
      test?.questions = testHelper.selectRandomQuestions(
          test?.questions ?? [], numberOfQuestionsForState);
      // Update state with success and response data
      apiStateHandler.setSuccess(test!);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  void checkAnswer(int choiceId, Question question) {
    if (question.answerId == choiceId) {
      wasAnsweredCorrectly.value = true;
    } else {
      wasAnsweredCorrectly.value = false;
    }
    update();
  }

  enableAnswerSelection() {
    isSelectingAnswerEnabled.value = true;
  }

  disableAnswerSelection() {
    isSelectingAnswerEnabled.value = true;
  }

  resetQuestionValues() {
    choiceId = 0;
    isAnswerSelected.value = false;
    wasAnsweredCorrectly.value = false;
    isSelectingAnswerEnabled.value = true;
    showAnswer.value = true;
    showDescription.value = false;
  }

  //going to next page after user sees the answer and press the next button
  goToNextQuestion(int pagesLength) {
    if (currentPageIndex.value < pagesLength - 1) {
      nextPage();
      resetQuestionValues();

      //incrementing page number
      questionPageNumber.value = questionPageNumber.value + 1;

      //incrementing show ad counter
      showAdCounter.value = showAdCounter.value + 1;

      //setting selected question value to false
      for (int i = 0; i < question!.choices.length; i++) {
        question?.choices[i].selected = false;
      }
    } else {
      Get.to(TestResult())?.then((_) {
        playConfetti();
      });
      isLastQuestionPageBackButtonEnabled.value = true;
    }
  }

  //showing answer after user press the next button and adding answer to answer list
  showQuestionAnswer(int choiceId, Question question) {
    //checking answer
    checkAnswer(choiceId, question);

    //preparing result object
    Result result = Result(
        id: question.id,
        isCorrect: wasAnsweredCorrectly.value,
        selectedAnswerId: choiceId);

    //adding result object to result list
    results.add(result);

    isAnswerSelected.value = true;
    isSelectingAnswerEnabled.value = false;
    showAnswer.value = false;
    showDescription.value = true;
  }

  // go to previous question and remove previous answer
  goToPreviousQuestion() {
    //resting question values
    resetQuestionValues();

    //removing the last item from list
    if (results.isNotEmpty) {
      results.removeAt(results.length - 1);
    }
    //setting default to show button if the last item reached
    if (results.isEmpty) {
      showProgress.value = false;
    }
    //decrementing  page number
    questionPageNumber.value = questionPageNumber.value - 1;

    //decrementing show ad counter
    showAdCounter.value = showAdCounter.value - 1;
  }

  resetControllerValues() {
    currentPageIndex.value = 0;
    choiceId = 0;
    isAnswerSelected.value = false;
    wasAnsweredCorrectly.value = false;
    isSelectingAnswerEnabled.value = true;
    showAnswer.value = true;
    showProgress.value = false;
    results = <Result>[];
    questionPageNumber.value = 1;
    showDescription.value = false;
    showAdCounter.value = 0;
  }

  Future<bool> onWillPop() async {
    if (isLastQuestionPageBackButtonEnabled.value == true) {
      resetControllerValues();
      return true;
    } else {
      return false;
    }
  }
}

import 'package:drivingexam/app/core/shared_controllers/native_ad_controller.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller_imports.dart';

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
  Rx<int> showAdCounter = 1.obs;
  Rx<bool> isLastQuestionPageBackButtonEnabled = false.obs;
  Question? question;
  int numberOfQuestionsForState = 0;
  late ScrollController scrollController;
  final HomeController homeController = Get.find();
  final MasterDataController masterDataController = Get.find();
  final NativeAdController nativeAdController = Get.find();
  Rx<bool> isLastTest = false.obs;

  TestController(this.testUrl, this.numberOfQuestionsForState);

  final apiStateHandler = ApiStateHandler<Test>();
  var httpService = Get.find<HttpService>();

  @override
  void onInit() {
    fetchData();
    SoundService.instance.loadSounds();
    scrollController = ScrollController();
    confettiController = ConfettiController();
    super.onInit();
  }

  // @override
  // void onClose() {
  //   confettiController.dispose();
  //   scrollController.dispose();
  //   super.onClose();
  // }

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

      //randomizing questions
      if (homeController.isRandomizeQuestions.value == true) {
        test?.questions = testHelper.selectRandomQuestions(
            test?.questions ?? [], numberOfQuestionsForState);
      } else {
        test?.questions =
            test!.questions.take(numberOfQuestionsForState).toList();
      }

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
      if (questionPageNumber.value <= test!.questions.length) {
        questionPageNumber.value = questionPageNumber.value + 1;
      }

      //incrementing show ad counter
      if (masterDataController.configs?.settings.showInterstitialAd == true) {
        showAdCounter.value = showAdCounter.value + 1;
      }

      //setting selected question value to false
      for (int i = 0; i < question!.choices.length; i++) {
        question?.choices[i].selected = false;
      }
    } else {
      Get.to(() => TestResult())?.then((_) {
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

    //setting selected question value to false
    for (int i = 0; i < question!.choices.length; i++) {
      question?.choices[i].selected = false;
    }
    //removing the last item from list
    if (results.isNotEmpty) {
      results.removeAt(results.length - 1);
    }
    //setting default to show button if the last item reached
    if (results.isEmpty) {
      showProgress.value = false;
    }

    //decrementing  page number
    if (questionPageNumber.value > 1) {
      questionPageNumber.value = questionPageNumber.value - 1;
    }

    //decrementing show ad counter
    if (masterDataController.configs?.settings.showInterstitialAd == true) {
      if (showAdCounter.value > 1) {
        showAdCounter.value = showAdCounter.value - 1;
      }
    }
  }

  Future<bool> onWillPop() async {
    if (isLastQuestionPageBackButtonEnabled.value == true) {
      return true;
    } else {
      return false;
    }
  }

  //autoScroll Bottom
  void autoScrollBottom() {
    if (homeController.isAutoScrollingEnabled.value == true) {
      Future.delayed(const Duration(milliseconds: 500), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  //autoScroll Top
  void autoScrollTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  //check if the test is the last test
  checkIsLastTest() {
    int currentTestIndex = homeController.allTests!.tests
        .indexWhere((element) => element.url == testUrl);
    if (currentTestIndex == homeController.allTests!.tests.length - 1) {
      isLastTest.value = true;
    } else {
      isLastTest.value = false;
    }
  }

  //go to next test
  nextTest() {
    int currentTestIndex = homeController.allTests!.tests
        .indexWhere((element) => element.url == testUrl);
    if (currentTestIndex + 1 < homeController.allTests!.tests.length) {
      String nextTestUrl =
          homeController.allTests!.tests[currentTestIndex + 1].url;
      testUrl = nextTestUrl;
    }
  }

  //go to  previous test
  previousTest() {
    int currentTestIndex = homeController.allTests!.tests
        .indexWhere((element) => element.url == testUrl);
    if (currentTestIndex <= homeController.allTests!.tests.length - 1) {
      String nextTestUrl =
          homeController.allTests!.tests[currentTestIndex - 1].url;
      testUrl = nextTestUrl;
    }
  }
}

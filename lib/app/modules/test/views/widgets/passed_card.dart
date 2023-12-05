import 'package:confetti/confetti.dart';
import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/helpers/home_helpers.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PassedWidget extends StatelessWidget {
  PassedWidget(
      {super.key,
      required this.incorrectAnswers,
      required this.numberOfQuestions});
  final themeData = Get.find<ThemeController>().themeData.value;
  final int incorrectAnswers;
  final int numberOfQuestions;
  final TestController controller = Get.find();
  final MasterDataController masterDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: themeData!.shadowColor.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/trophy.png",
                width: 200,
                height: 200,
              ),
              Text(
                "You Passed!",
                style: TextStyle(
                    color: themeData!.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "You have made $incorrectAnswers errors out of $numberOfQuestions questions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeData?.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder<TestController>(
                builder: (controller) => ConfettiWidget(
                  confettiController: controller.confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  controller.checkIsLastTest();
                  if (controller.isLastTest.value == true) {
                    controller.previousTest();
                    String testUrl = controller.testUrl;
                    int numberOfQuestionsForState =
                        controller.numberOfQuestionsForState;
                    Get.offAllNamed(
                      "/test",
                      arguments: {
                        'test_url': testUrl,
                        'number_of_questions': numberOfQuestionsForState,
                      },
                      // Remove routes until reaching the /home route
                      predicate: (route) => route.settings.name == "/home",
                    );
                    controller.resetControllerValues();
                  } else {
                    controller.nextTest();
                    String testUrl = controller.testUrl;
                    int numberOfQuestionsForState =
                        controller.numberOfQuestionsForState;
                    Get.offAllNamed(
                      "/test",
                      arguments: {
                        'test_url': testUrl,
                        'number_of_questions': numberOfQuestionsForState,
                      },
                      // Remove routes until reaching the /home route
                      predicate: (route) => route.settings.name == "/home",
                    );
                  }
                },
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData!.primaryColor,
                    border: Border.all(
                      color: themeData!.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              controller.isLastTest.value == false
                                  ? "GO TO NEXT TEST"
                                  : "GO TO PREVIOUS TEST",
                              style: TextStyle(
                                  color: themeData!.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.5.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAndToNamed("/test", arguments: {
                    'test_url': controller.testUrl,
                    'number_of_questions': controller.numberOfQuestionsForState
                  });
                  controller.resetControllerValues();
                },
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData!.lightGrey.withOpacity(0.6),
                    border: Border.all(
                      color: themeData!.whiteColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "RESTART TEST",
                            style: TextStyle(
                                color: themeData!.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.5.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(
                    "/home",
                    // Remove routes until reaching the /home route
                    predicate: (route) => route.settings.name == "/home",
                  );
                },
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData!.lightGrey.withOpacity(0.6),
                    border: Border.all(
                      color: themeData!.whiteColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "HOME",
                            style: TextStyle(
                                color: themeData!.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.5.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  HomeHelpers().openStores(
                      androidAppId:
                          masterDataController.configs!.appRateShare.androidId,
                      iOSAppId:
                          masterDataController.configs!.appRateShare.iosId);
                },
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData!.lightGrey.withOpacity(0.6),
                    border: Border.all(
                      color: themeData!.whiteColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "RATE",
                            style: TextStyle(
                                color: themeData!.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.5.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

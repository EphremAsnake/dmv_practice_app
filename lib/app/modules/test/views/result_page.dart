import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/modules/test/helper/test_helper.dart';
import 'package:drivingexam/app/modules/test/views/widgets/failed_card.dart';
import 'package:drivingexam/app/modules/test/views/widgets/passed_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestResult extends StatelessWidget {
  TestResult({super.key});
  final themeData = Get.find<ThemeController>().themeData.value;
  final TestController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    int incorrectAnswers =
        TestHelper().countErrorsFromResult(controller.results);
    bool passed = TestHelper().passedOrFailed(controller.results);
    controller.playConfetti();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(
          "/home",
          // Remove routes until reaching the /home route
          predicate: (route) => route.settings.name == "/home",
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed(
                            "/home",
                            // Remove routes until reaching the /home route
                            predicate: (route) => route.settings.name == "/home",
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: themeData?.whiteColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: themeData!.shadowColor.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: const Offset(
                                      0, 1), // horizontal, vertical offset
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 1,
                                height: 1,
                                child: Image.asset(
                                  "assets/images/home.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    HomeAD(),
                  ],
                ),
                passed
                    ? PassedWidget(
                        incorrectAnswers: incorrectAnswers,
                        numberOfQuestions: controller.test!.questions.length,
                      )
                    : FailedWidget(
                        incorrectAnswers: incorrectAnswers,
                        numberOfQuestions: controller.test!.questions.length,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

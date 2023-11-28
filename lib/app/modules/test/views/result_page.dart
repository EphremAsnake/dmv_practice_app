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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("/home");
                    },
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 1,
                          height: 1,
                          child: Center(
                            child: Icon(
                              Icons.home_outlined,
                              color: themeData!.blackColor.withOpacity(0.4),
                              size: 32,
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
            const SizedBox(
              height: 10,
            ),
            passed
                ? Expanded(
                    child: PassedWidget(incorrectAnswers: incorrectAnswers))
                : Expanded(
                    child: FailedWidget(incorrectAnswers: incorrectAnswers))
          ],
        ),
      ),
    );
  }
}

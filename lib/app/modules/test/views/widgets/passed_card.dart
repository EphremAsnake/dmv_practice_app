import 'package:confetti/confetti.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PassedWidget extends StatelessWidget {
  PassedWidget({
    super.key,
    required this.incorrectAnswers,
  });
  final themeData = Get.find<ThemeController>().themeData.value;
  final int incorrectAnswers;
  final TestController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: themeData!.shadowColor,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 8), // horizontal, vertical offset
            ),
            BoxShadow(
              color: themeData!.shadowColor,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -8), // horizontal, vertical offset
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          child: Column(
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
              Text(
                "You have made $incorrectAnswers errors out of 35 questions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themeData?.blackColor,
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
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData?.primaryColor,
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
                          child: Expanded(
                            child: Text(
                              "Go To Next Test",
                              style: TextStyle(
                                color: themeData?.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData?.whiteColor,
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
                          child: Expanded(
                            child: Text(
                              "Back To Incorrect & Skipped(28)",
                              style: TextStyle(
                                color: themeData?.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: themeData?.whiteColor,
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
                          child: Expanded(
                            child: Text(
                              "Restart Test",
                              style: TextStyle(
                                color: themeData?.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

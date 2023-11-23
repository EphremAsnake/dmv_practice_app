import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FailedWidget extends StatelessWidget {
  FailedWidget({
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
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: themeData!.shadowColor,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -8),
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
                "assets/images/lose.png",
                width: 200,
                height: 200,
              ),
              Text(
                "You Failed!",
                style: TextStyle(
                    color: themeData!.errorColor,
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
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
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
                          child: Expanded(
                            child: Text(
                              "Go To Next Test",
                              style: TextStyle(
                                color: themeData!.whiteColor,
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
                    color: themeData!.lightGrey,
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
                                color: themeData!.primaryColor,
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
                    color: themeData!.whiteColor,
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
                                color: themeData!.primaryColor,
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

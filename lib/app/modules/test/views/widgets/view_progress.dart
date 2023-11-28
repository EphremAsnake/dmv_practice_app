import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/data/models/result/result.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProgressCard extends StatelessWidget {
  List<Result> result;
  ProgressCard({
    required this.result,
    super.key,
  });
  final themeData = Get.find<ThemeController>().themeData.value;
  final TestController controller = Get.find();
  final UsStatesController usStatesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      result.length,
                      (index) {
                        int number = index + 1;
                        return SizedBox(
                          width: 40,
                          height: 40,
                          child: Card(
                            color: result[index].isCorrect == false
                                ? themeData?.errorColor.withOpacity(0.5)
                                : themeData?.primaryColor.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                number.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themeData?.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pass Mark",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeData?.blackColor,
                          ),
                        ),
                        Text(
                          usStatesController.state!.passingScore.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeData?.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Correct",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeData?.blackColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            result
                                .where((element) => element.isCorrect == true)
                                .toList()
                                .length
                                .toString(),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Incorrect & Skipped",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeData?.blackColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            result
                                .where((element) => element.isCorrect == false)
                                .toList()
                                .length
                                .toString(),
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

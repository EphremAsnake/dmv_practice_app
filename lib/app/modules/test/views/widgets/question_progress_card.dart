import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionProgress extends StatelessWidget {
  QuestionProgress({
    super.key,
  });

  final TestController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 237, 237),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 8), // horizontal, vertical offset
            ),
            BoxShadow(
              color: Color.fromARGB(255, 238, 237, 237),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -8), // horizontal, vertical offset
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        "Question ${controller.questionPageNumber.value}/${controller.apiStateHandler.data!.questions.length}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Obx(() => LinearProgressIndicator(
                            value: controller.questionPageNumber/
                                controller.tests!.questions.length,
                            minHeight: 10,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF016A70),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.results.isEmpty) {
                        Get.snackbar(
                          "Info",
                          "Please make some progress to view your progress",
                          duration: const Duration(seconds: 3),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        controller.showProgress.value =
                            !controller.showProgress.value;
                        controller.update();
                      }
                    },
                    child: Obx(
                      () => Text(
                        controller.showProgress.value
                            ? "Hide Progress"
                            : "View Progress",
                        style: const TextStyle(
                            color: Color(0xFF016A70),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

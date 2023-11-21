import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

class QuestionController extends StatelessWidget {
  QuestionController({
    super.key,
    required this.pages,
  });

  final List<Widget> pages;
  final TestController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.currentPageIndex.value > 0) {
                      controller.previousPage();
                      controller.goToPreviousQuestion();
                    }
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 248, 248),
                      border: Border.all(
                        color: const Color.fromARGB(255, 248, 248, 248),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LineIcon.chevronLeft(
                            size: 20.0,
                            color: Color(0xFF016A70),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Previous",
                              style: TextStyle(
                                  color: Color(0xFF016A70),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.showAnswer.value == true) {
                      controller.showQuestionAnswer(
                          controller.choiceId,
                          controller.tests!
                              .questions[controller.currentPageIndex.value]);
                    } else {
                      controller.goToNextQuestion(pages.length);
                    }
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF016A70),
                      border: Border.all(
                        color: const Color(0xFF016A70),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.questionPageNumber.value ==
                                      controller.tests?.questions.length
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const LineIcon.chevronRight(
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

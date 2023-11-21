// ignore: must_be_immutable
import 'package:drivingexam/app/core/shared_controllers/native_ad_controller.dart';
import 'package:drivingexam/app/data/models/test/test.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/modules/test/helper/test_helper.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:drivingexam/app/utils/shared_widgets/native_ad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int index;
  final NativeAdController nativeAdcontroller = Get.put(NativeAdController());
  QuestionCard({
    super.key,
    required this.question,
    required this.index,
  });
  final TestController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
              child: Card(
                elevation: 0,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Select an answer",
                          style: TextStyle(
                              color: Color.fromARGB(255, 189, 187, 187),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${index + 1}. ${question.question}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 24, 24, 24),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (question.imageUrl != null)
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              "${Keys.baseurl}${question.imageUrl!}",
                              width: 100,
                              height: 100,
                            )),
                      Flexible(
                        flex: 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: question.choices.length,
                          itemBuilder: (context, index) {
                            final choice = question.choices[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TestHelper().getBorderColor(
                                        controller.isAnswerSelected.value,
                                        choice.selected,
                                        controller.wasAnsweredCorrectly.value,
                                        choice.id,
                                        question.answerId),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    splashColor:
                                        const Color.fromARGB(255, 179, 232, 235)
                                            .withOpacity(0.5),
                                    title: Text(choice.text),
                                    leading: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: TestHelper().getBorderColor(
                                            controller.isAnswerSelected.value,
                                            choice.selected,
                                            controller
                                                .wasAnsweredCorrectly.value,
                                            choice.id,
                                            question.answerId),
                                        border: Border.all(
                                          color: TestHelper().getBorderColor(
                                              controller.isAnswerSelected.value,
                                              choice.selected,
                                              controller
                                                  .wasAnsweredCorrectly.value,
                                              choice.id,
                                              question.answerId),
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 +
                                              index), // Convert index to corresponding letter (A, B, C)
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (controller
                                              .isSelectingAnswerEnabled.value ==
                                          true) {
                                        for (int i = 0;
                                            i < question.choices.length;
                                            i++) {
                                          question.choices[i].selected =
                                              (i == index);
                                          controller.update();
                                        }
                                        Choice selectedAnswer = question.choices
                                            .where((element) =>
                                                element.selected == true)
                                            .first;
                                        controller.choiceId = selectedAnswer.id;

                                        controller.update();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.showDescription.value,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 0,
                              color: const Color.fromARGB(255, 248, 248, 248),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  question.explaniation,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<NativeAdController>(
                        init: nativeAdcontroller,
                        builder: (_) {
                          return buildNativeAd();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

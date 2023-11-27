// ignore: must_be_immutable
import 'package:drivingexam/app/core/shared_controllers/native_ad_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/data/models/test/test.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/modules/test/helper/test_helper.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:drivingexam/app/utils/shared_widgets/native_ad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int index;
  final NativeAdController nativeAdController = Get.put(NativeAdController());
  final themeData = Get.find<ThemeController>().themeData.value;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Select an answer",
                        style: TextStyle(
                            color: themeData?.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${index + 1}. ${question.question}",
                        style: TextStyle(
                            color: themeData?.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (question.imageUrl != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            "${Keys.baseurl}${question.imageUrl!}",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    Flexible(
                      flex: 3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: question.choices.length,
                        itemBuilder: (context, index) {
                          final choice = question.choices[index];
                          // if (controller.wasPreviousButtonPressed.value) {
                          //   choice.selected = false;
                          // }
                          return Obx(
                            () => Padding(
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
                                        themeData!.splashColor.withOpacity(0.5),
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
                                        child: TestHelper()
                                                .getCheckedOrWrongIcon(
                                                    controller
                                                        .isAnswerSelected.value,
                                                    choice.selected,
                                                    controller
                                                        .wasAnsweredCorrectly
                                                        .value,
                                                    choice.id,
                                                    question.answerId) ??
                                            const SizedBox.shrink(),
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

                                        //
                                        //checking answer
                                        controller.showQuestionAnswer(
                                            controller.choiceId,
                                            controller.tests!.questions[
                                                controller
                                                    .currentPageIndex.value]);

                                        controller.update();
                                      }
                                    },
                                  ),
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
                            color: themeData?.whiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15),
                              child: Text(
                                question.explaniation,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: themeData?.blackColor,
                                    fontSize: 13.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<NativeAdController>(
                      init: nativeAdController,
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
      ],
    );
  }
}

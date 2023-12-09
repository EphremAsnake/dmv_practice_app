// ignore: must_be_immutable
import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/data/models/test/test.dart';
import 'package:drivingexam/app/modules/home/controllers/home_controller.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/modules/test/helper/test_helper.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int index;
  final themeData = Get.find<ThemeController>().themeData.value;
  QuestionCard({
    super.key,
    required this.question,
    required this.index,
  });
  final TestController controller = Get.find();
  final HomeController homeController = Get.find();
  final MasterDataController masterDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.question = question;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "${index + 1}. ${question.question}",
                    style: TextStyle(
                        color: themeData?.blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (question.imageUrl != null)
                  GestureDetector(
                    onTap: () {
                      showImageModal(
                          context, "${Keys.baseurl}${question.imageUrl!}");
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Image.network(
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const SizedBox
                                .shrink(); // Show SizedBox.shrink() on image load failure
                          },
                          "${Keys.baseurl}${question.imageUrl!}",
                          width: 90.w,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: question.choices.length,
                  itemBuilder: (context, index) {
                    final choice = question.choices[index];
                    return Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10),
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
                            padding: const EdgeInsets.all(6.0),
                            child: ListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              dense: true,
                              // enableFeedback: true,
                              contentPadding: const EdgeInsets.all(0),
                              splashColor:
                                  themeData!.splashColor.withOpacity(0.5),
                              title: Text(
                                choice.text,
                                style: TextStyle(fontSize: 11.sp),
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: TestHelper().getChoiceBgColor(
                                        controller.isAnswerSelected.value,
                                        choice.selected,
                                        controller.wasAnsweredCorrectly.value,
                                        choice.id,
                                        question.answerId),
                                    border: Border.all(
                                      color: TestHelper().getBorderColor(
                                          controller.isAnswerSelected.value,
                                          choice.selected,
                                          controller.wasAnsweredCorrectly.value,
                                          choice.id,
                                          question.answerId),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: TestHelper().getCheckedOrWrongIcon(
                                            controller.isAnswerSelected.value,
                                            choice.selected,
                                            controller
                                                .wasAnsweredCorrectly.value,
                                            choice.id,
                                            question.answerId) ??
                                        const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                // //playing audio
                                // await SoundService.instance.playTapDownSound();
                                if (controller.isSelectingAnswerEnabled.value ==
                                    true) {
                                  for (int i = 0;
                                      i < question.choices.length;
                                      i++) {
                                    question.choices[i].selected = (i == index);
                                    controller.update();
                                  }
                                  Choice selectedAnswer = question.choices
                                      .where(
                                          (element) => element.selected == true)
                                      .first;

                                  controller.choiceId = selectedAnswer.id;

                                  //checking answer
                                  controller.showQuestionAnswer(
                                      controller.choiceId,
                                      controller.test!.questions[
                                          controller.currentPageIndex.value]);

                                  //auto scrolling to bottom
                                  controller.autoScrollBottom();

                                  //
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
                if (question.explanation != null && question.explanation != "")
                  Obx(
                    () => Visibility(
                      visible: controller.showDescription.value,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 5.0),
                        child: Card(
                          elevation: 0,
                          color: themeData?.primaryColor.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Text(
                              question.explanation!,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: themeData?.blackColor,
                                  fontSize: 10.5.sp),
                            ),
                          ),
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

void showImageModal(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Image.network(url,fit: BoxFit.cover),
      );
    },
  );
}

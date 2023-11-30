import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/utils/shared_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class QuestionProgress extends StatelessWidget {
  QuestionProgress({
    super.key,
  });

  final TestController controller = Get.find();
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    if (controller.results.isEmpty) {
      controller.showProgress.value = false;
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onTap: () {
            if (controller.results.isEmpty) {
              customSnackBar(
                title: "Information",
                body: "Please make some progress to view your progress",
              );
            } else {
              controller.showProgress.value = !controller.showProgress.value;
              controller.update();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: themeData!.whiteColor,
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
            height: 9.5.h,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          "Question ${controller.questionPageNumber.value}/${controller.apiStateHandler.data!.questions.length}",
                          style: TextStyle(
                              color: themeData?.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: themeData?.grayTextColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Obx(() => LinearProgressIndicator(
                              value: controller.questionPageNumber /
                                  controller.test!.questions.length,
                              minHeight: 10,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                themeData!.primaryColor,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Obx(
                      () => Text(
                        controller.showProgress.value
                            ? "Hide Progress"
                            : "View Progress",
                        style: TextStyle(
                            color: themeData!.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/controllers/home_controller.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/utils/helper/Interstitial_ad_manager.dart';
import 'package:drivingexam/app/utils/shared_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class QuestionController extends StatelessWidget {
  QuestionController({
    super.key,
    required this.pages,
  });

  final List<Widget> pages;
  final TestController controller = Get.find();
  final HomeController homeController = Get.find();
  final MasterDataController masterDataController = Get.find();
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 9.h,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //only runs in first question and a user already have answered the answer.
                    if (controller.currentPageIndex.value == 0 &&
                        controller.results.isNotEmpty) {
                      controller.goToPreviousQuestion();
                      controller.results.clear();
                      //only runs in  if the  question is not the first question.
                    } else if (controller.currentPageIndex.value > 0) {
                      controller.previousPage();
                      controller.goToPreviousQuestion();
                    }
                    controller.scrollController.animateTo(
                      controller.scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: themeData?.backgroundColor,
                      border: Border.all(
                        color: themeData!.whiteColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LineIcon.chevronLeft(
                                size: 20.0,
                                color: themeData?.primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Previous",
                                style: TextStyle(
                                  color: themeData?.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // if (controller.showAnswer.value == true) {
                    //   controller.showQuestionAnswer(
                    //       controller.choiceId,
                    //       controller.tests!
                    //           .questions[controller.currentPageIndex.value]);
                    // } else {
                    if (controller.choiceId == 0) {
                      customSnackBar(
                          title: "Info", body: "Please Select Answer");
                    } else if (controller.showAdCounter.value ==
                        masterDataController
                            .configs?.settings.interstitialAdFrequency) {
                      if (masterDataController
                              .configs?.settings.showInterstitialAd ==
                          true) {
                        await InterstitialAdManager().showInterstitialAd();
                        controller.goToNextQuestion(pages.length);
                        //loading ad for next use
                        InterstitialAdManager().loadAd();
                        //reset AD counter value
                        controller.showAdCounter.value = 0;
                      }
                    } else {
                      controller.goToNextQuestion(pages.length);
                    }
                    //auto scrolling to top
                    controller.autoScrollTop();
                  },
                  child: Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: themeData?.primaryColor,
                      border: Border.all(
                        color: themeData!.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  controller.questionPageNumber.value ==
                                          controller.test?.questions.length
                                      ? "Finish"
                                      : "Next",
                                  style: TextStyle(
                                    color: themeData?.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              LineIcon.chevronRight(
                                size: 20.0,
                                color: themeData?.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ],
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

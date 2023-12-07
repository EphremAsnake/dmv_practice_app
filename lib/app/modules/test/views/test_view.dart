import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/native_ad_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/controllers/home_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/test/views/widgets/test_widgets_export.dart';
import 'package:drivingexam/app/modules/test/views/widgets/view_progress.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/shared_widgets/custom_progress_indicator.dart';
import 'package:drivingexam/app/utils/shared_widgets/native_ad.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_controller.dart';

// ignore: must_be_immutable
class TestView extends GetView<TestController> {
  TestView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final MasterDataController masterDataController = Get.find();
  final HomeController homeController = Get.find();
  final NativeAdController nativeAdController = Get.find();

  @override
  Widget build(BuildContext context) {
    final NativeAdController nativeAdController = Get.find();

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        backgroundColor: themeData?.backgroundColor,
        body: GetBuilder<TestController>(
          builder: (controller) {
            if (controller.apiStateHandler.apiState == ApiState.loading) {
              return Center(child: CustomProgressIndicator());
            } else if (controller.apiStateHandler.apiState ==
                ApiState.success) {
              final List<Widget> questionPages = [
                for (int index = 0;
                    index < controller.apiStateHandler.data!.questions.length;
                    index++) ...[
                  QuestionCard(
                    question: controller.apiStateHandler.data!.questions[index],
                    index: index,
                  ),
                ]
              ];

              return SafeArea(
                child: masterDataController.configs?.settings.showNativeAd ==
                            false ||
                        homeController.isLoadingNativeAdFailed.value == true
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView(
                              physics: const ClampingScrollPhysics(),
                              controller: controller.scrollController,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.offAllNamed(
                                            "/home",
                                            // Remove routes until reaching the /home route
                                            predicate: (route) =>
                                                route.settings.name == "/home",
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: themeData?.whiteColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: themeData!.shadowColor
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 1,
                                                offset: const Offset(0,
                                                    1), // horizontal, vertical offset
                                              ),
                                            ],
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: SizedBox(
                                              width: 1,
                                              height: 1,
                                              child: Center(
                                                child: Icon(
                                                  Icons.chevron_left_outlined,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    HomeAD(),
                                  ],
                                ),
                                QuestionProgress(),
                                Obx(() => Visibility(
                                      visible: controller.showProgress.value,
                                      child: ProgressCard(
                                          result: controller.results),
                                    )),
                                ExpandablePageView.builder(
                                  animationCurve: Curves.easeIn,
                                  animateFirstPage: true,
                                  itemCount: questionPages.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() => questionPages[
                                        controller.currentPageIndex.value]);
                                  },
                                  onPageChanged: (index) {
                                    controller.currentPageIndex.value = index;
                                  },
                                  physics:
                                      const NeverScrollableScrollPhysics(), // Disable swiping between pages
                                ),
                                if (masterDataController
                                        .configs?.settings.showNativeAd ==
                                    true)
                                  GetBuilder<NativeAdController>(
                                    init: nativeAdController,
                                    builder: (_) {
                                      return buildNativeAd();
                                    },
                                  ),
                              ],
                            ),
                          ),
                          QuestionController(pages: questionPages),
                        ],
                      )
                    : ListView(
                        physics: const ClampingScrollPhysics(),
                        controller: controller.scrollController,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(
                                      "/home",
                                      // Remove routes until reaching the /home route
                                      predicate: (route) =>
                                          route.settings.name == "/home",
                                    );
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: themeData?.whiteColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: themeData!.shadowColor
                                              .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              1), // horizontal, vertical offset
                                        ),
                                      ],
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: SizedBox(
                                        width: 1,
                                        height: 1,
                                        child: Center(
                                          child: Icon(
                                            Icons.chevron_left_outlined,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              HomeAD(),
                            ],
                          ),
                          QuestionProgress(),
                          Obx(() => Visibility(
                                visible: controller.showProgress.value,
                                child: ProgressCard(result: controller.results),
                              )),
                          ExpandablePageView.builder(
                            animationCurve: Curves.easeIn,
                            animateFirstPage: true,
                            itemCount: questionPages.length,
                            itemBuilder: (context, index) {
                              return Obx(() => questionPages[
                                  controller.currentPageIndex.value]);
                            },
                            onPageChanged: (index) {
                              controller.currentPageIndex.value = index;
                            },
                            physics:
                                const NeverScrollableScrollPhysics(), // Disable swiping between pages
                          ),
                          if (masterDataController
                                  .configs?.settings.showNativeAd ==
                              true)
                            GetBuilder<NativeAdController>(
                              init: nativeAdController,
                              builder: (_) {
                                return buildNativeAd();
                              },
                            ),
                          QuestionController(pages: questionPages),
                        ],
                      ),
              );
            } else if (controller.apiStateHandler.apiState == ApiState.error) {
              return RefreshErrorWidget(
                showBackToHomeButton: true,
                assetImage: "assets/images/error.png",
                errorMessage: controller.apiStateHandler.error.toString(),
                onRefresh: () async {
                  controller.fetchData();
                  controller.update();
                  // reload the ad
                  nativeAdController.loadAd();
                  nativeAdController.update();
                },
              );
            } else {
              return RefreshErrorWidget(
                showBackToHomeButton: true,
                assetImage: "assets/images/error.png",
                errorMessage: controller.apiStateHandler.error.toString(),
                onRefresh: () async {
                  controller.fetchData();
                  controller.update();
                  // reload the ad
                  nativeAdController.loadAd();
                  nativeAdController.update();
                },
              );
            }
          },
        ),
      ),
    );
  }
}

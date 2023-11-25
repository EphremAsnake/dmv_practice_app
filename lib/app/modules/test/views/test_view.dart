import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/test/views/widgets/test_widgets_export.dart';
import 'package:drivingexam/app/modules/test/views/widgets/view_progress.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  TestView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData?.backgroundColor,
      body: GetBuilder<TestController>(
        builder: (controller) {
          if (controller.apiStateHandler.apiState == ApiState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.apiStateHandler.apiState == ApiState.success) {
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
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
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
                                      offset: const Offset(
                                          0, 1), // horizontal, vertical offset
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
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
                      const SizedBox(
                        height: 10,
                      ),
                      QuestionProgress(),
                      Visibility(
                        visible: controller.showProgress.value,
                        child: ProgressCard(result: controller.results),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 1.5),
                        //height: MediaQuery.of(context).size.height * 1.5,
                        child: PageView.builder(
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
                      ),
                      QuestionController(pages: questionPages),
                    ],
                  ),
                ),
              ),
            );
          } else if (controller.apiStateHandler.apiState == ApiState.error) {
            return RefreshErrorWidget(
              assetImage: "assets/images/error.png",
              errorMessage: controller.apiStateHandler.error.toString(),
              onRefresh: () async {
                controller.fetchData();
                controller.update();
              },
            );
          } else {
            return RefreshErrorWidget(
              assetImage: "assets/images/error.png",
              errorMessage: controller.apiStateHandler.error.toString(),
              onRefresh: () async {
                controller.fetchData();
                controller.update();
              },
            );
          }
        },
      ),
    );
  }
}

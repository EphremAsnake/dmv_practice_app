import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/test/views/widgets/test_widgets_export.dart';
import 'package:drivingexam/app/modules/test/views/widgets/view_progress.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 214, 214, 214)
                                              .withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 1), // horizontal, vertical offset
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                          const HomeAD(),
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
                      SizedBox(
                        height:  MediaQuery.of(context).size.height * 1.5,
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
            return Text('Error: ${controller.apiStateHandler.error}');
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

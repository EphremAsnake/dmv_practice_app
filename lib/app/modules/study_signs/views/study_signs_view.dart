import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/study_signs/views/widgets/study_signs_detail_modal.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:drivingexam/app/utils/shared_widgets/custom_progress_indicator.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_signs_controller.dart';

class StudySignsView extends GetView<StudySignsController> {
  StudySignsView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData?.backgroundColor,
      body: SafeArea(
        child: GetBuilder<StudySignsController>(
          initState: (_) {},
          builder: (_) {
            if (controller.apiStateHandler.apiState == ApiState.loading) {
              return Center(child: CustomProgressIndicator());
            } else if (controller.apiStateHandler.apiState ==
                ApiState.success) {
              return Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                  color:
                                      themeData!.shadowColor.withOpacity(0.5),
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
                      HomeAD(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: controller.apiStateHandler.data?.signsStudy
                          .signsAndDescriptions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showSignsDetailModal(controller.apiStateHandler
                                .data!.signsStudy.signsAndDescriptions[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: themeData!.whiteColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        themeData!.shadowColor.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // horizontal, vertical offset
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(
                                          "${Keys.baseurl}${controller.apiStateHandler.data!.signsStudy.signsAndDescriptions[index].image}",
                                          width: 100,
                                          height: 100,
                                        )),
                                  ),
                                  Center(
                                    child: Text(
                                      controller
                                          .apiStateHandler
                                          .data!
                                          .signsStudy
                                          .signsAndDescriptions[index]
                                          .name,
                                      style: TextStyle(
                                        color: themeData?.blackColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (controller.apiStateHandler.apiState == ApiState.error) {
              return RefreshErrorWidget(
                assetImage: "assets/images/error.png",
                errorMessage: controller.apiStateHandler.error!,
                onRefresh: () async {
                  controller.fetchData();
                  controller.update();
                },
              );
            } else {
              return RefreshErrorWidget(
                assetImage: "assets/images/error.png",
                errorMessage: "Unknown Error Occured",
                onRefresh: () async {
                  controller.fetchData();
                  controller.update();
                },
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:drivingexam/app/core/shared_controllers/search_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/study_signs/views/widgets/study_signs_detail_modal.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:drivingexam/app/utils/shared_widgets/custom_progress_indicator.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:drivingexam/app/utils/shared_widgets/search_bar.dart';
import 'package:drivingexam/app/utils/shared_widgets/search_results_not_found.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_signs_controller.dart';

class StudySignsView extends GetView<StudySignsController> {
  StudySignsView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final SearchBarController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () {
          // Close keyboard focus when tapping outside the text field
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                searchController.clearSearch();
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
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CustomSearchBar(
                          onChange: (value) {
                            controller.search(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible:
                            controller.filteredSignsAndDescriptions.isEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: SearchResultsNotFoundCard(
                              message: 'Please retype traffic sign name again'),
                        ),
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
                          itemCount:
                              controller.filteredSignsAndDescriptions.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showSignsDetailModal(controller
                                    .filteredSignsAndDescriptions[index]);
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
                                        color: themeData!.shadowColor,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0,
                                            8), // horizontal, vertical offset
                                      ),
                                      BoxShadow(
                                        color: themeData!.shadowColor,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0,
                                            -8), // horizontal, vertical offset
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 5),
                                      Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.network(
                                              "${Keys.baseurl}${controller.filteredSignsAndDescriptions[index].image}",
                                              width: 100,
                                              height: 100,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Center(
                                          child: Text(
                                            controller
                                                .filteredSignsAndDescriptions[
                                                    index]
                                                .name,
                                            style: TextStyle(
                                              color: themeData?.blackColor,
                                              fontSize: 17,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
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
                } else if (controller.apiStateHandler.apiState ==
                    ApiState.error) {
                  return RefreshErrorWidget(
                    showBackToHomeButton: true,
                    assetImage: "assets/images/error.png",
                    errorMessage: controller.apiStateHandler.error!,
                    onRefresh: () async {
                      controller.fetchData();
                      controller.update();
                    },
                  );
                } else {
                  return RefreshErrorWidget(
                    showBackToHomeButton: true,
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
        ),
      ),
    );
  }
}

import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_widgets_exports.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/utils/extensions/title_case_extension.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final UsStatesController usStatesController = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF016A70), // Replace with your desired color
    ));

    return WillPopScope(
      onWillPop: () async {
        showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: themeData?.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: SingleChildScrollView(
                              child: Settings(themeData: themeData)),
                        ),
                        backgroundColor: themeData?.backgroundColor,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        enableDrag: true,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 8),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: themeData?.whiteColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: themeData!.shadowColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // horizontal, vertical offset
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 1,
                            height: 1,
                            child: Image.asset(
                              "assets/images/menu.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: HomeAD()),
                ],
              ),
              HomePageTopCard(),
              ReadManual(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<UsStatesController>(
                      init: UsStatesController(),
                      initState: (_) {},
                      builder: (_) {
                        if (usStatesController.cacheStateHandler.apiState ==
                            ApiState.loading) {
                          return Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2),
                                    child: Container(
                                      width: double.infinity,
                                      height: 80,
                                      color: themeData!.whiteColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (usStatesController
                                .cacheStateHandler.apiState ==
                            ApiState.success) {
                          return GetBuilder<HomeController>(
                            init: HomeController(),
                            initState: (_) {},
                            builder: (_) {
                              if (controller.apiStateHandler.apiState ==
                                  ApiState.loading) {
                                return Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2),
                                          child: Container(
                                            width: double.infinity,
                                            height: 80,
                                            color: themeData!.whiteColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else if (controller.apiStateHandler.apiState ==
                                  ApiState.success) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: controller
                                        .apiStateHandler.data!.tests.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 2.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/test", arguments: {
                                              'test_url': controller
                                                  .apiStateHandler
                                                  .data!
                                                  .tests[index]
                                                  .url,
                                              'number_of_questions':
                                                  usStatesController
                                                      .cacheStateHandler
                                                      .data!
                                                      .numberOfQuestions
                                            });
                                          },
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        themeData!.shadowColor,
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    offset: const Offset(0,
                                                        4), // horizontal, vertical offset
                                                  ),
                                                  BoxShadow(
                                                    color:
                                                        themeData!.shadowColor,
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    offset: const Offset(0,
                                                        -4), // horizontal, vertical offset
                                                  ),
                                                ],
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 110,
                                              child: Card(
                                                elevation: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(height: 7),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${usStatesController.cacheStateHandler.data!.numberOfQuestions.toString()} QUESTIONS",
                                                              style: TextStyle(
                                                                color: themeData
                                                                    ?.grayTextColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              "PASSING SCORE ${usStatesController.cacheStateHandler.data!.passingScore.toString()}",
                                                              style: TextStyle(
                                                                color: themeData
                                                                    ?.grayTextColor,
                                                              ),
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        controller
                                                            .apiStateHandler
                                                            .data!
                                                            .tests[index]
                                                            .name
                                                            .toTitleCase(),
                                                        style: TextStyle(
                                                          color: themeData
                                                              ?.blackColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              LineIcon
                                                                  .timesCircle(
                                                                size: 20.0,
                                                                color: themeData
                                                                    ?.primaryColor,
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                "${usStatesController.cacheStateHandler.data!.numberOfQuestions - usStatesController.cacheStateHandler.data!.passingScore} Mistakes Allowed",
                                                                style:
                                                                    TextStyle(
                                                                  color: themeData
                                                                      ?.primaryColor,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: themeData!
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 4.0,
                                                                horizontal: 8,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  LineIcon
                                                                      .playCircle(
                                                                    size: 20.0,
                                                                    color: themeData
                                                                        ?.primaryColor,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "Start",
                                                                    style: TextStyle(
                                                                        color: themeData
                                                                            ?.primaryColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else if (controller.apiStateHandler.apiState ==
                                  ApiState.error) {
                                return RefreshErrorWidget(
                                  showBackToHomeButton: false,
                                  assetImage: "assets/images/error.png",
                                  errorMessage:
                                      controller.apiStateHandler.error!,
                                  onRefresh: () async {
                                    controller.fetchData();
                                    controller.update();
                                  },
                                );
                              } else {
                                return RefreshErrorWidget(
                                  showBackToHomeButton: false,
                                  assetImage: "assets/images/error.png",
                                  errorMessage:
                                      "No internet connection, please check your internet connection and try again.",
                                  onRefresh: () async {
                                    controller.fetchData();
                                    controller.update();
                                  },
                                );
                              }
                            },
                          );
                        } else if (usStatesController
                                .cacheStateHandler.apiState ==
                            ApiState.error) {
                          return RefreshErrorWidget(
                            showBackToHomeButton: false,
                            assetImage: "assets/images/error.png",
                            errorMessage:
                                "No internet connection, please check your internet connection and try again.",
                            onRefresh: () async {
                              usStatesController.fetchData();
                              usStatesController.savedStateData();
                              usStatesController.readStateData();
                              usStatesController.update();
                            },
                          );
                        } else {
                          return RefreshErrorWidget(
                            showBackToHomeButton: false,
                            assetImage: "assets/images/error.png",
                            errorMessage:
                                "No internet connection, please check your internet connection and try again.",
                            onRefresh: () async {
                              usStatesController.fetchData();
                              usStatesController.savedStateData();
                              usStatesController.readStateData();
                              usStatesController.update();
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

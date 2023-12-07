import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/shared_widgets/custom_progress_indicator.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  AboutView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final MasterDataController masterDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<MasterDataController>(
            init: MasterDataController(),
            initState: (_) {},
            builder: (_) {
              if (masterDataController.apiStateHandler.apiState ==
                  ApiState.loading) {
                return Center(
                  child: CustomProgressIndicator(),
                );
              } else if (masterDataController.apiStateHandler.apiState ==
                  ApiState.success) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                          predicate: (route) => route.settings.name == "/home",
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
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                            height: 86.h,
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0.sp),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          masterDataController
                                              .configs!.aboutApp,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: themeData?.blackColor,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (masterDataController.apiStateHandler.apiState ==
                  ApiState.error) {
                return RefreshErrorWidget(
                  showBackToHomeButton: true,
                  assetImage: "assets/images/error.png",
                  errorMessage: masterDataController.apiStateHandler.error!,
                  onRefresh: () async {
                    masterDataController.getMasterData();
                    masterDataController.readMasterData();
                    masterDataController.update();
                  },
                );
              } else {
                return RefreshErrorWidget(
                  showBackToHomeButton: true,
                  assetImage: "assets/images/error.png",
                  errorMessage:
                      "No internet connection, please check your internet connection and try again.",
                  onRefresh: () async {
                    masterDataController.getMasterData();
                    masterDataController.readMasterData();
                    masterDataController.update();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

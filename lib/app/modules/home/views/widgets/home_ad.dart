import 'dart:io';

import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/helpers/home_helpers.dart';
import 'package:drivingexam/app/utils/extensions/title_case_extension.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeAD extends StatelessWidget {
  HomeAD({
    super.key,
  });
  final themeData = Get.find<ThemeController>().themeData.value;
  final MasterDataController masterDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MasterDataController>(
      init: MasterDataController(),
      initState: (_) {},
      builder: (_) {
        if (masterDataController.apiStateHandler.apiState == ApiState.loading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: const Color.fromARGB(255, 255, 255, 255),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: themeData!.whiteColor,
                ),
              ),
            ),
          );
        } else if (masterDataController.apiStateHandler.apiState ==
            ApiState.success) {
          if (masterDataController.configs!.houseAd.show == true) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  if (Platform.isAndroid) {
                    if (masterDataController.configs!.houseAd.androidUrl
                            .contains("http") ==
                        true) {
                      HomeHelpers().launchWebUrl(
                          masterDataController.configs!.houseAd.androidUrl);
                    } else {
                      HomeHelpers().openStores(
                        androidAppId:
                            masterDataController.configs!.houseAd.androidUrl,
                      );
                    }
                  } else if (Platform.isIOS) {
                    if (masterDataController.configs!.houseAd.iosUrl
                            .contains("http") ==
                        true) {
                      HomeHelpers().launchWebUrl(
                          masterDataController.configs!.houseAd.iosUrl);
                    } else {
                      HomeHelpers().openStores(
                        iOSAppId: masterDataController.configs!.houseAd.iosUrl,
                      );
                    }
                  }
                },
                child: Row(
                  children: [
                    Container(
                      width: 75.w,
                      decoration: BoxDecoration(
                        color: themeData!.whiteColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                    masterDataController.configs!.houseAd.title
                                        .toTitleCase(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: themeData!.blackColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: themeData?.primaryColor,
                                      border: Border.all(
                                        color: themeData!.primaryColor
                                            .withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 15),
                                      child: Text(
                                        masterDataController
                                            .configs!.houseAd.buttonText
                                            .toTitleCase(),
                                        style: TextStyle(
                                          color: themeData!.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        } else if (masterDataController.apiStateHandler.apiState ==
            ApiState.error) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

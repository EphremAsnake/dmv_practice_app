import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:shimmer/shimmer.dart';

class HomePageTopCard extends StatelessWidget {
  HomePageTopCard({
    super.key,
  });
  final UsStatesController usStateController = Get.find();
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
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
        height: 185,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<UsStatesController>(
                  init: usStateController,
                  initState: (_) {},
                  builder: (_) {
                    if (usStateController.cacheStateHandler.apiState ==
                        ApiState.loading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 20,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: themeData!.whiteColor,
                            ),
                          ),
                        ),
                      );
                    } else if (usStateController.cacheStateHandler.apiState ==
                        ApiState.success) {
                      return Text(
                        "${usStateController.state?.name} Driver's Examination",
                        style: TextStyle(
                            color: themeData!.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      );
                    } else if (usStateController.cacheStateHandler.apiState ==
                        ApiState.error) {
                      return Text(
                          'Error: ${usStateController.apiStateHandler.error}');
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Want To Practice Traffic Signs First ?",
                  style: TextStyle(
                      color: themeData!.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/study-signs');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeData!.primaryColor,
                          border: Border.all(
                            color: themeData!.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: Row(
                            children: [
                              LineIcon.play(
                                size: 20.0,
                                color: themeData!.whiteColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Start Practicing",
                                style: TextStyle(
                                  color: themeData!.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_page_top_card.dart';
import 'package:drivingexam/app/modules/home/views/widgets/read_manual.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final UsStatesController usStatesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData?.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                          offset:
                              const Offset(0, 1), // horizontal, vertical offset
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                HomeAD(),
              ],
            ),
            HomePageTopCard(),
            ReadManual(),
            const SizedBox(height: 5),
            GetBuilder<UsStatesController>(
              init: UsStatesController(),
              initState: (_) {},
              builder: (_) {
                if (usStatesController.cacheStateHandler.apiState ==
                    ApiState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (usStatesController.cacheStateHandler.apiState ==
                    ApiState.success) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/test");
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: themeData!.shadowColor,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          0, 8), // horizontal, vertical offset
                                    ),
                                    BoxShadow(
                                      color: themeData!.shadowColor,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          0, -8), // horizontal, vertical offset
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${usStatesController.cacheStateHandler.data!.numberOfQuestions.toString()} QUESTIONS",
                                              style: TextStyle(
                                                color: themeData?.blackColor,
                                              ),
                                            ),
                                            Text(
                                              "PASSING SCORE ${usStatesController.cacheStateHandler.data!.passingScore.toString()}",
                                              style: TextStyle(
                                                color: themeData?.blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Practice Test ${index + 1}",
                                          style: TextStyle(
                                            color: themeData?.blackColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                LineIcon.timesCircle(
                                                  size: 20.0,
                                                  color:
                                                      themeData?.primaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "8 Mistakes Allowed",
                                                  style: TextStyle(
                                                      color: themeData
                                                          ?.primaryColor),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      themeData!.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 15,
                                                ),
                                                child: Row(
                                                  children: [
                                                    LineIcon.playCircle(
                                                      size: 20.0,
                                                      color: themeData
                                                          ?.primaryColor,
                                                    ),
                                                    const SizedBox(width: 5),
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
                } else if (usStatesController.cacheStateHandler.apiState ==
                    ApiState.error) {
                  return Text(
                      'Error: ${usStatesController.cacheStateHandler.error}');
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

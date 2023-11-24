import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:drivingexam/app/utils/shared_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UsStatesView extends GetView<UsStatesController> {
  UsStatesView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData?.backgroundColor,
      body: SafeArea(
        child: GetBuilder<UsStatesController>(
          builder: (controller) {
            if (controller.apiStateHandler.apiState == ApiState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.apiStateHandler.apiState ==
                ApiState.success) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select State",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: themeData?.blackColor,
                            fontFamily: 'lato'),
                      ),
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount:
                              controller.apiStateHandler.data?.states.length,
                          itemBuilder: (context, index) {
                            final isSelected =
                                index == controller.selectedCardIndex.value;
                            return GestureDetector(
                              onTap: () {
                                controller.setSelectedCardIndex(index);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: themeData!.shadowColor,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: themeData!.shadowColor,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, -8),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    borderOnForeground: true,
                                    shape: isSelected
                                        ? RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: themeData!.primaryColor,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          )
                                        : null,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                            themeData?.primaryColor,
                                        child: Text(
                                          controller.apiStateHandler.data!
                                              .states[index].name
                                              .substring(0, 1),
                                          style: TextStyle(
                                              color: themeData?.whiteColor),
                                        ),
                                      ),
                                      title: Text(
                                        controller.apiStateHandler.data!
                                            .states[index].name,
                                        style: TextStyle(
                                            color: themeData?.blackColor),
                                      ),
                                      trailing: isSelected
                                          ? LineIcon.checkCircle(
                                              size: 20.0,
                                              color: themeData?.primaryColor,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.selectedCardIndex.value != -1) {
                        controller.savedStateData();
                        Get.toNamed('/home');
                      } else {
                        customSnackBar(
                            title: "Error",
                            body: "Please Select State To Proceed");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: themeData?.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeData?.shadowColor,
                                fontFamily: 'lato'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                errorMessage: "Unknown Error Occurred",
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

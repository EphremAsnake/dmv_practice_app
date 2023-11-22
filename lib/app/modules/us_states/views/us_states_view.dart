import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/helper/app_colors.dart';
import 'package:drivingexam/app/utils/helper/hex_color_helper.dart';
import 'package:drivingexam/app/utils/helper/master_data_helper.dart';
import 'package:drivingexam/app/utils/shared_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:get/get.dart';

import '../controllers/us_states_controller.dart';

// ignore: must_be_immutable
class UsStatesView extends GetView<UsStatesController> {
  UsStatesView({Key? key}) : super(key: key);
  MasterDataController masterDataController = Get.find();
  AppColors appColors = MasterDataHelper().appColors;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MasterDataController>(
      init: masterDataController,
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor(appColors.getBackgroundColor),
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
                                color: HexColor(appColors.getBlackColor),
                                fontFamily: 'lato'),
                          ),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: controller
                                  .apiStateHandler.data?.states.length,
                              itemBuilder: (context, index) {
                                final isSelected =
                                    index == controller.selectedCardIndex.value;
                                return GestureDetector(
                                  onTap: () {
                                    controller.setSelectedCardIndex(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 238, 237, 237),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: Offset(0,
                                                8), // horizontal, vertical offset
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 238, 237, 237),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: Offset(0,
                                                -8), // horizontal, vertical offset
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        borderOnForeground: true,
                                        shape: isSelected
                                            ? RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: HexColor(appColors
                                                        .getPrimaryColor),
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              )
                                            : null,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: HexColor(
                                                appColors.getPrimaryColor),
                                            child: Text(
                                              controller.apiStateHandler.data!
                                                  .states[index].name
                                                  .substring(0, 1),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          title: Text(controller.apiStateHandler
                                              .data!.states[index].name),
                                          trailing: isSelected
                                              ? LineIcon.checkCircle(
                                                  size: 20.0,
                                                  color: HexColor(appColors
                                                      .getPrimaryColor),
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
                                color: HexColor(appColors.getPrimaryColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'CONTINUE',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'lato'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (controller.apiStateHandler.apiState ==
                    ApiState.error) {
                  return Text('Error: ${controller.apiStateHandler.error}');
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/study_signs/views/widgets/study_signs_detail_modal.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_signs_controller.dart';

class StudySignsView extends GetView<StudySignsController> {
  const StudySignsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: GetBuilder<StudySignsController>(
          initState: (_) {},
          builder: (_) {
            if (controller.apiStateHandler.apiState == ApiState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.apiStateHandler.apiState ==
                ApiState.success) {
              return Column(
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
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
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
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
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
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
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
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 70, 70, 70),
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
              return Text('Error: ${controller.apiStateHandler.error}');
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/shared_widgets/pdf_reader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ReadManual extends StatelessWidget {
  ReadManual({
    super.key,
  });

  final UsStatesController controller = Get.find();
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    controller.readStateData();
    return GetBuilder<UsStatesController>(
      init: controller,
      initState: (_) {},
      builder: (_) {
        if (controller.cacheStateHandler.apiState == ApiState.loading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
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
        } else if (controller.cacheStateHandler.apiState == ApiState.success) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => PDFReader(
                    pdfTitle: "${controller.state!.name} Drivers Manual",
                    pdfPath: controller.state!.dmvManualLink));
              },
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
                      offset:
                          const Offset(0, -8), // horizontal, vertical offset
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 80,
                              child: Image.asset(
                                "assets/images/manual.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              "Read ${controller.state!.name}'s Drivers Manual",
                              style: TextStyle(
                                color: themeData!.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: themeData!.primaryColor,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (controller.cacheStateHandler.apiState == ApiState.error) {
          return Text('Error: ${controller.apiStateHandler.error}');
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

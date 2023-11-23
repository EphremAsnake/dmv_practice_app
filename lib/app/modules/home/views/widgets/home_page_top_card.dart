import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

class HomePageTopCard extends StatelessWidget {
  HomePageTopCard({
    super.key,
  });
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
                Text(
                  "Virginia Driver's Examination",
                  style: TextStyle(
                      color: themeData!.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
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

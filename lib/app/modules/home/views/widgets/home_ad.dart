import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAD extends StatelessWidget {
  HomeAD({
    super.key,
  });
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: themeData!.whiteColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ace Your DMV Written Test with",
                style: TextStyle(
                  fontSize: 12,
                  color: themeData!.blackColor,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeData?.primaryColor,
                  border: Border.all(
                    color: themeData!.primaryColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15),
                  child: Text(
                    "Cheat Sheet",
                    style: TextStyle(
                      color: themeData!.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

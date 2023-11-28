import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomProgressIndicator extends StatelessWidget {
  CustomProgressIndicator({super.key});
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 50,
      color: themeData?.primaryColor,
      duration: const Duration(seconds: 1),
    );
  }
}

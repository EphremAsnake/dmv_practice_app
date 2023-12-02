import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final themeData = Get.find<ThemeController>().themeData.value;
SnackbarController customSnackBar(
    {required String title, required String body}) {
  return Get.snackbar(
    title,
    body,
    duration: const Duration(seconds: 2),
    backgroundColor: themeData?.primaryColor.withOpacity(0.05),
    colorText: themeData?.blackColor,
    snackPosition: SnackPosition.BOTTOM,
    dismissDirection: DismissDirection.horizontal,
  );
}

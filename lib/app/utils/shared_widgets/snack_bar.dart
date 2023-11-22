import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController customSnackBar(
    {required String title, required String body}) {
  return Get.snackbar(
    title,
    body,
    duration: const Duration(seconds: 3),
    backgroundColor: const Color(0xFF016A70).withOpacity(0.5),
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    dismissDirection: DismissDirection.horizontal,
  );
}

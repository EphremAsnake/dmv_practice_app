import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/data/models/signs_study/signs_study.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final themeData = Get.find<ThemeController>().themeData.value;
void showSignsDetailModal(SignsAndDescription item) {
  Get.dialog(
    AlertDialog(
      elevation: 1,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    "${Keys.baseurl}${item.image}",
                    width: 100,
                    height: 100,
                  )),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: themeData?.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                item.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: themeData?.blackColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the modal
            Get.back();
          },
          child: Text(
            'CLOSE',
            style: TextStyle(
                color: themeData?.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

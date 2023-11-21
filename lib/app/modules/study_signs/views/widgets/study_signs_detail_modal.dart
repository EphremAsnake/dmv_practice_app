import 'package:drivingexam/app/data/models/signs_study/signs_study.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSignsDetailModal(SignsAndDescription item) {
  Get.dialog(
    AlertDialog(
      elevation: 1,
      content: Wrap(
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
                  style: const TextStyle(
                      color: Color(0xFF016A70),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              item.description,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the modal
            Get.back();
          },
          child: const Text(
            'CLOSE',
            style: TextStyle(
                color: Color(0xFF016A70),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

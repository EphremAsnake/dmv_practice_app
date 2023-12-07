import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  final TextEditingController controller = TextEditingController();
  final RxBool isClearIconVisible = false.obs;
  final String defaultSearchLabel = "Search";

  void onTextFieldFocusChange(bool hasFocus) {
    isClearIconVisible.value = hasFocus;
  }

  void clearSearch() {
    controller.clear();
  }
}

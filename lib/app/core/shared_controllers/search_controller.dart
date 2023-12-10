import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/utils/helper/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  final TextEditingController controller = TextEditingController();
  final RxBool isClearIconVisible = false.obs;
  final String defaultSearchLabel = "Search";
  final UsStatesController usStatesController = Get.find();

  void onTextFieldFocusChange(bool hasFocus) {
    isClearIconVisible.value = hasFocus;
  }

  void clearSearch() {
    controller.clear();
    // Checking if UsStatesController is registered
    bool isRegistered = GetInstance().isRegistered<UsStatesController>();
    if (isRegistered) {
      usStatesController.filteredStates.clear();
      usStatesController.selectedCardIndex.value = -1;
      if (InternetConnectivity().isConnected == true) {
        usStatesController.fetchData();
      } else {
        usStatesController.fetchDataFromCache();
      }
      usStatesController.update();
    }
  }

  @override
  void onClose() {
    controller.dispose();
    usStatesController.filteredStates.clear();
    usStatesController.selectedCardIndex.value = -1;
    if (InternetConnectivity().isConnected == true) {
      usStatesController.fetchData();
    } else {
      usStatesController.fetchDataFromCache();
    }
    usStatesController.update();
    super.onClose();
  }
}

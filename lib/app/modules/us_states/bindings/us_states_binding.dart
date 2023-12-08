import 'package:drivingexam/app/core/shared_controllers/search_controller.dart';
import 'package:get/get.dart';

import '../controllers/us_states_controller.dart';

class UsStatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchBarController());
    Get.lazyPut<UsStatesController>(
      () => UsStatesController(),
      fenix: true,
    );
  }
}

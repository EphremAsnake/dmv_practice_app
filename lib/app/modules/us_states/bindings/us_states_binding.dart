import 'package:get/get.dart';

import '../controllers/us_states_controller.dart';

class UsStatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsStatesController>(
      () => UsStatesController(),
    );
  }
}

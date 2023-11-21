import 'package:get/get.dart';

import '../controllers/study_signs_controller.dart';

class StudySignsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudySignsController>(
      () => StudySignsController(),
    );
  }
}

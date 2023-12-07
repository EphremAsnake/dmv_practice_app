import 'package:drivingexam/app/core/shared_controllers/search_controller.dart';
import 'package:get/get.dart';

import '../controllers/study_signs_controller.dart';

class StudySignsBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<SearchBarController>(
      () => SearchBarController(),
    );
    Get.lazyPut<StudySignsController>(
      () => StudySignsController(),
    );
   
  }
}

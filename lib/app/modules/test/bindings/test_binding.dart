import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Map<String, dynamic> arguments = Get.arguments;
    String testUrl = arguments['test_url'];
    int numberOfQuestions = arguments['number_of_questions'];
    Get.lazyPut<TestController>(
      () => TestController(testUrl,numberOfQuestions),
    );
  }
}

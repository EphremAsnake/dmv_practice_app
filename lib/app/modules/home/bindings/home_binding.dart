import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(), fenix: true
    );
    final MasterDataController masterDataController = Get.find();
    masterDataController.readMasterData();
  }
}

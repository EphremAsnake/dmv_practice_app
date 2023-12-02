import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MasterDataHelper {
  MasterDataController controller = Get.find();
  static final _storage = Hive.box('driving_exam');
  getMasterData() async {
    try {
      dynamic autoScrollingCacheKey = _storage.get(Keys.autoScrollingCacheKey);
      dynamic randomizeQuestionCacheKey = _storage.get(Keys.randomizeQuestionsCacheKey);
      if (autoScrollingCacheKey == null) {
        _storage.put(Keys.autoScrollingCacheKey, false);
      }
      if (randomizeQuestionCacheKey == null) {
        _storage.put(Keys.randomizeQuestionsCacheKey, false);
      }
      controller.readMasterData();
      if (controller.configs == null) {
        await controller.getMasterData();
      }
    } catch (ex) {}
  }
}

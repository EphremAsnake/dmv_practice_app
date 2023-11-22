import 'package:drivingexam/app/core/cache/local_storage.dart';
import 'package:drivingexam/app/data/models/us_states/us_states.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:drivingexam/app/routes/app_pages.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:get/get.dart';

Future<String> determineInitialRoute() async {
  CacheStorageService cacheStorageService = CacheStorageService();
  try {
    dynamic cachedData =
        await cacheStorageService.getSavedData(Keys.savedStateCacheKey);
    if (cachedData != null) {
      State.fromJson(cachedData);
      // injecting usStatesController
      Get.lazyPut<UsStatesController>(() => UsStatesController());
      return AppPages.INITIAL;
    } else {
      return AppPages.FIRST_RUN_INITIAL;
    }
  } catch (error) {
    return AppPages.FIRST_RUN_INITIAL;
  }
}

import 'dart:convert';
import 'package:drivingexam/app/core/cache/local_storage.dart';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/data/models/test/all_test_list.dart';
import 'package:drivingexam/app/modules/home/controllers/all_tests_http_attribuites.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/helper/internet_connectivity.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  final apiStateHandler = ApiStateHandler<AllTests>();
  var httpService = Get.find<HttpService>();
  Rx<bool> isAutoScrollingEnabled = false.obs;
  Rx<bool> isRandomizeQuestions = false.obs;
  static final _storage = Hive.box('driving_exam');
  CacheStorageService cacheStorageService = CacheStorageService();

  @override
  void onInit() {
    isAutoScrollingEnabled.value = _storage.get(Keys.autoScrollingCacheKey);
    if (InternetConnectivity().isConnected == true) {
      fetchData();
    } else {
      fetchFromCacheData();
    }
    super.onInit();
  }

  AllTests? allTests;

  //fetching data from api
  void fetchData() async {
    apiStateHandler.setLoading();
    try {
      dynamic response =
          await httpService.sendHttpRequest(AllTestsHttpAttributes());

      final result = jsonDecode(response.body);
      allTests = AllTests.fromJson(result);
      //caching data
      cacheStorageService.saveData(Keys.allTestsCacheKey, allTests!.toJson());
      // Update state with success and response data
      apiStateHandler.setSuccess(allTests!);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  //fetching data from cache
  void fetchFromCacheData() async {
    apiStateHandler.setLoading();
    try {
      dynamic cachedData =
          await cacheStorageService.getSavedData(Keys.allTestsCacheKey);

      if (cachedData != null) {
        allTests = AllTests.fromJson(cachedData);
      }

      // Update state with success and response data
      apiStateHandler.setSuccess(allTests!);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  // Reactive variable to track the modal state
  RxBool isModalOpen = false.obs;

  // Method to toggle the modal state
  void toggleModal() {
    isModalOpen.toggle();
  }

  //toggling auto scrolling behavior
  void toggleAutoScrollingBehavior(bool state) {
    _storage.put(Keys.autoScrollingCacheKey, state);
    isAutoScrollingEnabled.value = state;
  }

  //toggling randomize question feature
  void toggleRandomizingQuestion(bool state) {
    _storage.put(Keys.randomizeQuestionsCacheKey, state);
    isRandomizeQuestions.value = state;
  }
}

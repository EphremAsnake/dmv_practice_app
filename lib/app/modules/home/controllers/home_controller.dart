import 'dart:io';

import 'package:drivingexam/app/modules/home/controllers/home_controller_imports.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller_imports.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_controller.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends GetxController {
  final apiStateHandler = ApiStateHandler<AllTests>();
  var httpService = Get.find<HttpService>();
  Rx<bool> isAutoScrollingEnabled = false.obs;
  Rx<bool> isRandomizeQuestions = false.obs;
  UsStatesController usStatesController = Get.find();

  static final _storage = Hive.box('driving_exam');
  CacheStorageService cacheStorageService = CacheStorageService();
  final MasterDataController masterDataController = Get.find();

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
        statusBarColor:   Color(0xFF016A70),
      ));
    });
    isAutoScrollingEnabled.value = _storage.get(Keys.autoScrollingCacheKey);
    if (usStatesController.isHomePageInsertedIntoRoute.value == false) {
      usStatesController.isHomePageInsertedIntoRoute.value = true;
      if (InternetConnectivity().isConnected == true) {
        fetchData();
      } else {
        fetchFromCacheData();
      }
    } else {
      fetchFromCacheData();
    }
    if (masterDataController.configs?.adSettings.showInterstitialAd == true) {
      InterstitialAdManager().loadAd();
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

  Future<void> share() async {
    Platform.isAndroid
        ? await Share.share(
            masterDataController.configs!.appRateShare.androidShare)
        : await Share.share(
            masterDataController.configs!.appRateShare.iosShare);
  }
}

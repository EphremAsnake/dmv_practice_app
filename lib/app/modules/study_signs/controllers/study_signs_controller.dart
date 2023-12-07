import 'dart:convert';
import 'package:drivingexam/app/core/cache/local_storage.dart';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/data/models/signs_study/signs_study.dart';
import 'package:drivingexam/app/modules/study_signs/controllers/study_signs_http_attribuites.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/helper/internet_connectivity.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:get/get.dart';

class StudySignsController extends GetxController {
  @override
  void onInit() {
    if (InternetConnectivity().isConnected == true) {
      fetchData();
    } else {
      fetchDataFromCache();
    }
    super.onInit();
  }

  SignsStudy? signsStudy;
  final apiStateHandler = ApiStateHandler<SignsStudy>();
  var httpService = Get.find<HttpService>();
  CacheStorageService cacheStorageService = CacheStorageService();
  List<SignsAndDescription> filteredSignsAndDescriptions = [];

  void fetchData() async {
    apiStateHandler.setLoading();
    try {
      dynamic response =
          await httpService.sendHttpRequest(StudySignsHttpAttributes());

      //decode the api result to model type
      final result = jsonDecode(response.body);
      signsStudy = SignsStudy.fromJson(result);
      //caching data
      cacheStorageService.saveData(
          Keys.studySignsCacheKey, signsStudy!.toJson());
      apiStateHandler.setSuccess(signsStudy!);
      filteredSignsAndDescriptions =
          signsStudy!.signsStudy.signsAndDescriptions;
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  void fetchDataFromCache() async {
    apiStateHandler.setLoading();
    try {
      dynamic cachedData =
          await cacheStorageService.getSavedData(Keys.allTestsCacheKey);

      if (cachedData != null) {
        signsStudy = SignsStudy.fromJson(cachedData);
      }
      apiStateHandler.setSuccess(signsStudy!);
      filteredSignsAndDescriptions =
          signsStudy!.signsStudy.signsAndDescriptions;
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  void search(String value) {
    filteredSignsAndDescriptions = apiStateHandler
        .data!.signsStudy.signsAndDescriptions
        .where((element) => element.name.toLowerCase().contains(value))
        .toList();

    if (filteredSignsAndDescriptions.isEmpty && value.isEmpty) {
      filteredSignsAndDescriptions
          .addAll(apiStateHandler.data!.signsStudy.signsAndDescriptions);
    }
    update();
  }
}

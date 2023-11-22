import 'dart:convert';
import 'dart:io';
import 'package:drivingexam/app/core/cache/local_storage.dart';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/core/shared_controllers/master_data_http_attribuites.dart';
import 'package:drivingexam/app/data/models/configs/configs.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:get/get.dart';

class MasterDataController extends GetxController {
  var httpService = Get.find<HttpService>();
  CacheStorageService cacheStorageService = CacheStorageService();
  Configs? configs;
  final apiStateHandler = ApiStateHandler<Configs>();

  //get master data from API
  Future getMasterData() async {
    try {
      dynamic response =
          await httpService.sendHttpRequest(MasterDataHttpAttributes());
      final result = jsonDecode(response.body);
      //caching the data
      cacheStorageService.saveData(Keys.configsCacheKey, result);
      update();
    } on HttpException catch (ex) {
      HttpException(HandleHttpException().handleHttpResponse(ex));
    } catch (error) {}
  }

  //read master data from cache
  Future readMasterData() async {
    apiStateHandler.setLoading();
    try {
      dynamic cachedData =
          await cacheStorageService.getSavedData(Keys.configsCacheKey);

      if (cachedData != null) {
        configs = Configs.fromJson(cachedData);
      }
      // Update state with success and response data
      apiStateHandler.setSuccess(configs!);
      update();
    } catch (error) {
      // Update state with error message
      apiStateHandler.setError(error.toString());
      update();
    }
  }
}

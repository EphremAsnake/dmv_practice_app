import 'dart:convert';

import 'package:drivingexam/app/core/cache/local_storage.dart';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/data/models/us_states/us_states.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_http_attribuites.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:get/get.dart';

class UsStatesController extends GetxController {
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  UsStates? usStates;
  State? state;
  RxInt selectedCardIndex = RxInt(-1);
  CacheStorageService cacheStorageService = CacheStorageService();

  final apiStateHandler = ApiStateHandler<UsStates>();
  final cacheStateHandler = ApiStateHandler<State>();
  var httpService = Get.find<HttpService>();

  Future<void> fetchData() async {
    apiStateHandler.setLoading();
    try {
      dynamic response =
          await httpService.sendHttpRequest(UsStatesHttpAttributes());

      final result = jsonDecode(response.body);
      usStates = UsStates.fromJson(result);
      usStates?.states.sort((a, b) => a.name.compareTo(b.name));
      // Update state with success and response data
      apiStateHandler.setSuccess(usStates!);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  setSelectedCardIndex(int index) {
    selectedCardIndex.value = index;
    update();
  }

  //get master data from API
  void savedStateData() async {
    try {
      State state = usStates!.states[selectedCardIndex.value];
      //caching the data
      cacheStorageService.saveData(Keys.savedStateCacheKey, state.toJson());
      update();
    } catch (error) {}
  }

  //read master data from cache
  void readStateData() async {
    cacheStateHandler.setLoading();
    try {
      dynamic cachedData =
          await cacheStorageService.getSavedData(Keys.savedStateCacheKey);

      if (cachedData != null) {
        state = State.fromJson(cachedData);
      }
      // Update state with success and response data
      cacheStateHandler.setSuccess(state!);
      update();
    } catch (error) {
      // Update state with error message
      cacheStateHandler.setError(error.toString());
      update();
    }
  }
}

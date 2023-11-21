import 'dart:convert';
import 'dart:io';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/data/models/us_states/us_states.dart';
import 'package:drivingexam/app/modules/us_states/controllers/us_states_http_attribuites.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:get/get.dart';

class UsStatesController extends GetxController {
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  UsStates? usStates;
  RxInt selectedCardIndex = RxInt(-1);


  final apiStateHandler = ApiStateHandler<UsStates>();
  var httpService = Get.find<HttpService>();

  void fetchData() async {
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
    } on HttpException catch (ex) {
      // Update state with error message
      HttpException(HandleHttpException().handleHttpResponse(ex));
      apiStateHandler.setError(ex.toString());
      update();
    } catch (error) {
      // Update state with error message
      apiStateHandler.setError(error.toString());
      update();
    }
  }

  setSelectedCardIndex(int index){
    selectedCardIndex.value = index;
    update();
  }
}

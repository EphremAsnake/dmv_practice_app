import 'dart:convert';
import 'dart:io';
import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/data/models/signs_study/signs_study.dart';
import 'package:drivingexam/app/modules/study_signs/controllers/study_signs_http_attribuites.dart';
import 'package:drivingexam/app/utils/helper/api_state_handler.dart';
import 'package:get/get.dart';

class StudySignsController extends GetxController {
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  SignsStudy? signsStudy;
  final apiStateHandler = ApiStateHandler<SignsStudy>();
  var httpService = Get.find<HttpService>();

  void fetchData() async {
    apiStateHandler.setLoading();
    try {
      dynamic response =
          await httpService.sendHttpRequest(StudySignsHttpAttributes());
          
      //decode the api result to model type
      final result = jsonDecode(response.body);
      signsStudy = SignsStudy.fromJson(result);
      apiStateHandler.setSuccess(signsStudy!);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }
}

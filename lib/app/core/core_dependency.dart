import 'package:drivingexam/app/core/http_client/http_service.dart';
import 'package:drivingexam/app/core/http_client/http_service_impl.dart';
import 'package:get/get.dart';

class CoreDependencyCreator {
  static init() {
    Get.put<HttpService>(HttpServiceImpl());
  }
}
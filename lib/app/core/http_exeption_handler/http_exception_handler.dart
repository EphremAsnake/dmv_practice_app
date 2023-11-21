import 'dart:io';
import 'package:drivingexam/app/core/http_exeption_handler/custom_http_exception.dart';

class HandleHttpException {
  String handleHttpResponse(Exception e) {
    if (e is SocketException) {
      return "No Internet connection";
    } else if (e is HttpException) {
      return 'HTTP error occurred.';
    } else if (e is FormatException) {
      return 'Invalid data format.';
    } else if (e is ConnectionTimedOutException) {
      return 'Request time out.';
    } else if (e is BadRequestException) {
      return e.message.toString();
    } else if (e is UnAuthorizedException) {
      return e.message.toString();
    } else if (e is NotFoundException) {
      return e.message.toString();
    } else if (e is FetchDataException) {
      return e.message.toString();
    } else {
      return 'Unknown error occured.';
    }
  }
}
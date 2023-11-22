import 'dart:io';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/get.dart';

class PDFController extends GetxController {
  late PDFDocument document;
  String pdfPath;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isError = false.obs;

  PDFController(this.pdfPath);

  @override
  void onInit() {
    super.onInit();
    loadDocument();
  }

  Future<void> loadDocument() async {
    isLoading.value = true;
    try {
      document = await PDFDocument.fromURL(
        pdfPath,
        cacheManager: CacheManager(
          Config(
            Keys.manualsCacheKey,
            stalePeriod: const Duration(days: 30),
            maxNrOfCacheObjects: 10,
          ),
        ),
      );
      isError.value = true;
      isLoading.value = false;
      update();
    } on HttpException catch (ex) {
      // Update state with error message
      String exceptionMessage = HandleHttpException().handleHttpResponse(ex);
      Get.snackbar(
        "Error",
        exceptionMessage,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      isError.value = true;
      isLoading.value = false;
      update();
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed To Load Manual",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      isError.value = true;
      isLoading.value = false;
      update();
    }
  }
}

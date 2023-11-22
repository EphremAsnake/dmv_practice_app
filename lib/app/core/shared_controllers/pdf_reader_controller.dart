import 'dart:io';
import 'package:drivingexam/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:drivingexam/app/utils/shared_widgets/snack_bar.dart';
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
      customSnackBar(title: 'Error', body: exceptionMessage);
      isError.value = true;
      isLoading.value = false;
      update();
    } catch (error) {
      customSnackBar(title: 'Error', body: "Failed To Load Manual");
      isError.value = true;
      isLoading.value = false;
      update();
    }
  }
}

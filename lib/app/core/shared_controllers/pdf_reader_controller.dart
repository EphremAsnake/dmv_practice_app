import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/get.dart';

class PDFController extends GetxController {
  late PDFDocument document;
  String pdfPath;
  Rx<bool> isLoading = false.obs;

  PDFController(this.pdfPath);

  @override
  void onInit() {
    super.onInit();
    loadDocument();
  }

  Future<void> loadDocument() async {
    isLoading.value = true;
    try {
      document = await PDFDocument.fromURL(pdfPath);
    } catch (ex) {}
    isLoading.value = false;
    update();
  }
}

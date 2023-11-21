import 'package:drivingexam/app/core/shared_controllers/pdf_reader_controller.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PDFReader extends StatelessWidget {
  final String pdfTitle;
  final String pdfPath;

  const PDFReader({super.key, required this.pdfPath, required this.pdfTitle});

  @override
  Widget build(BuildContext context) {
    final PDFController controller = Get.put(PDFController(pdfPath));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF016A70),
        elevation: 0,
        title: Text(pdfTitle),
      ),
      body: GetBuilder<PDFController>(
        init: controller,
        initState: (_) {},
        builder: (_) {
          if (controller.isLoading.value == true) {
            return const Center(child:  CircularProgressIndicator());
          } else {
            return PDFViewer(
              scrollDirection: Axis.vertical,
              document: controller.document,
              lazyLoad: false,
              zoomSteps: 1,
              numberPickerConfirmWidget: const Text(
                "Confirm",
              ),
              pickerButtonColor: const Color(0xFF016A70),
            );
          }
        },
      ),
    );
  }
}

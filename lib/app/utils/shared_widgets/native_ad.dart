import 'package:drivingexam/app/core/shared_controllers/native_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Widget buildNativeAd() {
  final NativeAdController nativeAdController = Get.find();
  if (nativeAdController.nativeAd != null &&
      nativeAdController.nativeAdIsLoaded) {
    return GetBuilder<NativeAdController>(
      init: nativeAdController,
      builder: (_) {
        return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200,
              minHeight: 150,
              maxHeight: 350,
              maxWidth: 350,
            ),
            child: AdWidget(ad: nativeAdController.nativeAd!),
          ),
        );
      },
    );
  }
  else {
    return const SizedBox.shrink();
  }
}

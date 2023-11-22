import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class NativeAdController extends GetxController {
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;

  @override
  void onInit() {
    super.onInit();
    // Create the ad objects and load ads.
    loadAd();
    startAdRefresher();
  }

  loadAd() {
    nativeAd = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAdIsLoaded = true;
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        cornerRadius: 20.0,
        templateType: TemplateType.medium,
        mainBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
        ),
      ),
    )..load();
  }

  void startAdRefresher() {
    Timer.periodic(const Duration(seconds: 30), (_) {
      loadAd();
      update();
    });
  }

  @override
  void onClose() {
    nativeAd?.dispose();
    super.onClose();
  }
}

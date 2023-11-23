import 'dart:async';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

final themeData = Get.find<ThemeController>().themeData.value;

class NativeAdController extends GetxController {
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;

  @override
  void onInit() {
    super.onInit();
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
        mainBackgroundColor: themeData?.whiteColor,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: themeData?.whiteColor,
          backgroundColor: themeData?.primaryColor,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
          
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: themeData?.blackColor,
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

import 'dart:io';
import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:drivingexam/app/modules/home/controllers/home_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class NativeAdController extends GetxController {
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;
  final MasterDataController masterDataController = Get.find();
  final HomeController homeController = Get.find();
  final themeData = Get.find<ThemeController>().themeData.value;

  @override
  void onInit() {
    super.onInit();
    if (masterDataController.configs?.settings.showNativeAd == true) {
      loadAd();
      update();
    }
  }

  loadAd() {
    nativeAd = NativeAd(
      adUnitId: Platform.isAndroid
          ? masterDataController.configs!.settings.androidNativeAdId
          : masterDataController.configs!.settings.iosNativeAdId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAdIsLoaded = true;
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          homeController.isLoadingNativeAdFailed.value = true;
          ad.dispose();
          update();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        cornerRadius: 10.0,
        templateType: TemplateType.medium,
        mainBackgroundColor: themeData?.whiteColor,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: themeData?.whiteColor,
          backgroundColor: themeData?.primaryColor,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: themeData?.grayTextColor,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: themeData?.grayTextColor,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: themeData?.blackColor,
        ),
      ),
    )..load();
  }

  // @override
  // void onClose() {
  //   nativeAd?.dispose();
  //   super.onClose();
  // }
}

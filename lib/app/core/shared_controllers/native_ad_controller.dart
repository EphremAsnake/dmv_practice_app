import 'dart:io';
import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class NativeAdController extends GetxController {
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;
  final MasterDataController masterDataController = Get.find();
  RxBool isLoadingNativeAdFailed = false.obs;
  RxBool isAdReloadRequested = false.obs;
  final themeData = Get.find<ThemeController>().themeData.value;

  @override
  void onInit() {
    super.onInit();
    if (masterDataController.configs?.adSettings.showNativeAd == true &&
        isAdReloadRequested.value == false) {
      loadAd();
    }
  }

  void loadAd() {
    nativeAd = createNativeAd();
    nativeAd?.load();
    update();
  }

  NativeAd createNativeAd() {
    return NativeAd(
      adUnitId: Platform.isAndroid
          ? masterDataController.configs!.adSettings.androidNativeAdId
          : masterDataController.configs!.adSettings.iosNativeAdId,
      request: const AdManagerAdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAdIsLoaded = true;
          isLoadingNativeAdFailed.value = false;
          print('Ad loaded successfully');
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          isLoadingNativeAdFailed.value = true;
          print('Ad failed to load: $error');
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
    );
  }

  Future<void> reloadAd() async {
    if (nativeAd != null) {
      nativeAd!.dispose();
    }
    isLoadingNativeAdFailed.value = false;
    nativeAdIsLoaded = false;
    if (masterDataController.configs?.adSettings.showNativeAd == true) {
      loadAd();
    }
  }
}

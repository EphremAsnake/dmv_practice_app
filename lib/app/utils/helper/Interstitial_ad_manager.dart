import 'dart:io';
import 'package:drivingexam/app/utils/keys/keys.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  static final InterstitialAdManager _instance = InterstitialAdManager._internal();
  InterstitialAd? _interstitialAd;

  factory InterstitialAdManager() {
    return _instance;
  }

  InterstitialAdManager._internal();

  final adUnitId = Platform.isAndroid ? Keys.adAndroidKey : Keys.adIosKey;

  // Loads an interstitial ad.
  void loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        // loadAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        // loadAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
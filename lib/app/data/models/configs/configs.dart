import 'dart:convert';

Configs configsFromJson(String str) => Configs.fromJson(json.decode(str));

String configsToJson(Configs data) => json.encode(data.toJson());

class Configs {
    Settings settings;
    AppConfig appConfig;
    HouseAd houseAd;

    Configs({
        required this.settings,
        required this.appConfig,
        required this.houseAd,
    });

    factory Configs.fromJson(Map<String, dynamic> json) => Configs(
        settings: Settings.fromJson(json["settings"]),
        appConfig: AppConfig.fromJson(json["app_config"]),
        houseAd: HouseAd.fromJson(json["house_ad"]),
    );

    Map<String, dynamic> toJson() => {
        "settings": settings.toJson(),
        "app_config": appConfig.toJson(),
        "house_ad": houseAd.toJson(),
    };
}

class AppConfig {
    AppColors appColors;

    AppConfig({
        required this.appColors,
    });

    factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        appColors: AppColors.fromJson(json["app_colors"]),
    );

    Map<String, dynamic> toJson() => {
        "app_colors": appColors.toJson(),
    };
}

class AppColors {
    String whiteColor;
    String backgroundColor;
    String primaryColor;
    String secondaryColor;
    String blackColor;
    String primaryTextColor;
    String secondaryTextColor;
    String grayTextColor;
    String blackTextColor;
    String shadowColor;
    String primaryGrayColor;
    String splashColor;
    String errorColor;
    String lightGrey;

    AppColors({
        required this.whiteColor,
        required this.backgroundColor,
        required this.primaryColor,
        required this.secondaryColor,
        required this.blackColor,
        required this.primaryTextColor,
        required this.secondaryTextColor,
        required this.grayTextColor,
        required this.blackTextColor,
        required this.shadowColor,
        required this.primaryGrayColor,
        required this.splashColor,
        required this.errorColor,
        required this.lightGrey,
    });

    factory AppColors.fromJson(Map<String, dynamic> json) => AppColors(
        whiteColor: json["white_color"],
        backgroundColor: json["background_color"],
        primaryColor: json["primary_color"],
        secondaryColor: json["secondary_color"],
        blackColor: json["black_color"],
        primaryTextColor: json["primary_text_color"],
        secondaryTextColor: json["secondary_text_color"],
        grayTextColor: json["gray_text_color"],
        blackTextColor: json["black_text_color"],
        shadowColor: json["shadow_color"],
        primaryGrayColor: json["primary_gray_color"],
        splashColor: json["splash_color"],
        errorColor: json["error_color"],
        lightGrey: json["light_grey"],
    );

    Map<String, dynamic> toJson() => {
        "white_color": whiteColor,
        "background_color": backgroundColor,
        "primary_color": primaryColor,
        "secondary_color": secondaryColor,
        "black_color": blackColor,
        "primary_text_color": primaryTextColor,
        "secondary_text_color": secondaryTextColor,
        "gray_text_color": grayTextColor,
        "black_text_color": blackTextColor,
        "shadow_color": shadowColor,
        "primary_gray_color": primaryGrayColor,
        "splash_color": splashColor,
        "error_color": errorColor,
        "light_grey": lightGrey,
    };
}

class HouseAd {
    String title;
    String buttonText;
    bool show;
    bool typeApp;
    String iosUrl;
    String androidUrl;

    HouseAd({
        required this.title,
        required this.buttonText,
        required this.show,
        required this.typeApp,
        required this.iosUrl,
        required this.androidUrl,
    });

    factory HouseAd.fromJson(Map<String, dynamic> json) => HouseAd(
        title: json["title"],
        buttonText: json["button_text"],
        show: json["show"],
        typeApp: json["type_app"],
        iosUrl: json["ios_url"],
        androidUrl: json["android_url"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "button_text": buttonText,
        "show": show,
        "type_app": typeApp,
        "ios_url": iosUrl,
        "android_url": androidUrl,
    };
}

class Settings {
    String androidInterstitialAdId;
    String androidNativeAdId;
    String iosInterstitialAdId;
    String iosNativeAdId;
    int interstitialAdFrequency;

    Settings({
        required this.androidInterstitialAdId,
        required this.androidNativeAdId,
        required this.iosInterstitialAdId,
        required this.iosNativeAdId,
        required this.interstitialAdFrequency,
    });

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        androidInterstitialAdId: json["android_interstitial_ad_id"],
        androidNativeAdId: json["android_native_ad_id"],
        iosInterstitialAdId: json["ios_interstitial_ad_id"],
        iosNativeAdId: json["ios_native_ad_id"],
        interstitialAdFrequency: json["interstitial_ad_frequency"],
    );

    Map<String, dynamic> toJson() => {
        "android_interstitial_ad_id": androidInterstitialAdId,
        "android_native_ad_id": androidNativeAdId,
        "ios_interstitial_ad_id": iosInterstitialAdId,
        "ios_native_ad_id": iosNativeAdId,
        "interstitial_ad_frequency": interstitialAdFrequency,
    };
}

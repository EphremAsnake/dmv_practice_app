import 'dart:convert';

Configs configsFromJson(String str) => Configs.fromJson(json.decode(str));

String configsToJson(Configs data) => json.encode(data.toJson());

class Configs {
  AppConfig appConfig;
  AppRateShare appRateShare;
  HouseAd houseAd;
  String aboutApp;

  Configs({
    required this.appConfig,
    required this.houseAd,
    required this.aboutApp,
    required this.appRateShare,
  });

  factory Configs.fromJson(Map<String, dynamic> json) => Configs(
      appConfig: AppConfig.fromJson(json["app_config"]),
      houseAd: HouseAd.fromJson(json["house_ad"]),
      appRateShare: AppRateShare.fromJson(json["app_rate_share"]),
      aboutApp: json["about_app"]);

  Map<String, dynamic> toJson() => {
        "app_config": appConfig.toJson(),
        "house_ad": houseAd.toJson(),
        "about_app": aboutApp,
        "app_rate_share": appRateShare.toJson(),
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
  String blackColor;
  String grayTextColor;
  String shadowColor;
  String splashColor;
  String errorColor;
  String lightGrey;

  AppColors({
    required this.whiteColor,
    required this.backgroundColor,
    required this.primaryColor,
    required this.blackColor,
    required this.grayTextColor,
    required this.shadowColor,
    required this.splashColor,
    required this.errorColor,
    required this.lightGrey,
  });

  factory AppColors.fromJson(Map<String, dynamic> json) => AppColors(
        whiteColor: json["white_color"],
        backgroundColor: json["background_color"],
        primaryColor: json["primary_color"],
        blackColor: json["black_color"],
        grayTextColor: json["gray_text_color"],
        shadowColor: json["shadow_color"],
        splashColor: json["splash_color"],
        errorColor: json["error_color"],
        lightGrey: json["light_grey"],
      );

  Map<String, dynamic> toJson() => {
        "white_color": whiteColor,
        "background_color": backgroundColor,
        "primary_color": primaryColor,
        "black_color": blackColor,
        "gray_text_color": grayTextColor,
        "shadow_color": shadowColor,
        "splash_color": splashColor,
        "error_color": errorColor,
        "light_grey": lightGrey,
      };
}

class HouseAd {
  String title;
  String buttonText;
  bool show;
  String iosUrl;
  String androidUrl;

  HouseAd({
    required this.title,
    required this.buttonText,
    required this.show,
    required this.iosUrl,
    required this.androidUrl,
  });

  factory HouseAd.fromJson(Map<String, dynamic> json) => HouseAd(
        title: json["title"],
        buttonText: json["button_text"],
        show: json["show"],
        iosUrl: json["ios_url"],
        androidUrl: json["android_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "button_text": buttonText,
        "show": show,
        "ios_url": iosUrl,
        "android_url": androidUrl,
      };
}

class AppRateShare {
  String iosId;
  String androidId;
  String iosShare;
  String androidShare;

  AppRateShare({
    required this.iosId,
    required this.androidId,
    required this.iosShare,
    required this.androidShare,
  });

  factory AppRateShare.fromJson(Map<String, dynamic> json) => AppRateShare(
        iosId: json["ios_id"],
        androidId: json["android_id"],
        iosShare: json["ios_share"],
        androidShare: json["android_share"],
      );

  Map<String, dynamic> toJson() => {
        "ios_id": iosId,
        "android_id": androidId,
        "ios_share": iosShare,
        "android_share": androidShare,
      };
}

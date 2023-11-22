// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppColors {
  String whiteColor;
  String backgroundColor;
  String primaryColor;
  String secondaryColor;
  String blackColor;
  String blackTextColor;
  String primaryTextColor;
  String secondaryTextColor;
  String grayTextColor;
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
    required this.blackTextColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.grayTextColor,
    required this.shadowColor,
    required this.primaryGrayColor,
    required this.splashColor,
    required this.errorColor,
    required this.lightGrey,
  });

  get getWhiteColor => whiteColor;
  set setWhiteColor(whiteColor) => this.whiteColor = whiteColor;

  get getBackgroundColor => backgroundColor;

  set setBackgroundColor(backgroundColor) =>
      this.backgroundColor = backgroundColor;

  get getPrimaryColor => primaryColor;

  set setPrimaryColor(primaryColor) => this.primaryColor = primaryColor;

  get getSecondaryColor => secondaryColor;

  set setSecondaryColor(secondaryColor) => this.secondaryColor = secondaryColor;

  get getBlackColor => blackColor;

  set setBlackColor(blackColor) => this.blackColor = blackColor;

  get getPrimaryTextColor => primaryTextColor;

  set setPrimaryTextColor(primaryTextColor) =>
      this.primaryTextColor = primaryTextColor;

  get getSecondaryTextColor => secondaryTextColor;

  set setSecondaryTextColor(secondaryTextColor) =>
      this.secondaryTextColor = secondaryTextColor;

  get getGrayTextColor => grayTextColor;

  set setGrayTextColor(grayTextColor) => this.grayTextColor = grayTextColor;

  get getBlackTextColor => blackTextColor;

  set setBlackTextColor(blackTextColor) => this.blackTextColor = blackTextColor;

  get getShadowColor => shadowColor;

  set setShadowColor(shadowColor) => this.shadowColor = shadowColor;

  get getPrimaryGrayColor => primaryGrayColor;

  set setPrimaryGrayColor(primaryGrayColor) =>
      this.primaryGrayColor = primaryGrayColor;

  get getSplashColor => splashColor;

  set setSplashColor(splashColor) => this.splashColor = splashColor;

  get getErrorColor => errorColor;

  set setErrorColor(errorColor) => this.errorColor = errorColor;

  get getLightGrey => lightGrey;

  set setLightGrey(lightGrey) => this.lightGrey = lightGrey;
}

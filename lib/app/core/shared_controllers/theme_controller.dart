import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/utils/helper/app_colors.dart';
import 'package:drivingexam/app/utils/helper/hex_color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final MasterDataController controller = Get.find();
  Rx<ThemeDataModel?> themeData = Rx<ThemeDataModel?>(null);

  void getThemeData() {
    final theme = ThemeDataModel(
      whiteColor: HexColor(
          controller.configs?.appConfig.appColors.whiteColor ?? "#ffffff"),
      backgroundColor: HexColor(
          controller.configs?.appConfig.appColors.backgroundColor ?? "#F8F8F8"),
      primaryColor: HexColor(
          controller.configs?.appConfig.appColors.primaryColor ?? "#016A70"),
      secondaryColor: HexColor(
          controller.configs?.appConfig.appColors.secondaryColor ?? "#FCCCC5"),
      blackColor: HexColor(
          controller.configs?.appConfig.appColors.blackColor ?? "#000000"),
      primaryTextColor: HexColor(
          controller.configs?.appConfig.appColors.primaryTextColor ??
              "#ffffff"),
      secondaryTextColor: HexColor(
          controller.configs?.appConfig.appColors.secondaryTextColor ??
              "#43374F"),
      grayTextColor: HexColor(
        controller.configs?.appConfig.appColors.grayTextColor ?? "#747475",
      ),
      blackTextColor: HexColor(
        controller.configs?.appConfig.appColors.blackTextColor ?? "#DCDFE5",
      ),
      shadowColor: HexColor(
          controller.configs?.appConfig.appColors.shadowColor ?? "#EEEDED"),
      primaryGrayColor: HexColor(
          controller.configs?.appConfig.appColors.primaryGrayColor ??
              "#9B9A9A"),
      splashColor: HexColor(
          controller.configs?.appConfig.appColors.splashColor ?? "#B3E8EB"),
      errorColor: HexColor(
          controller.configs?.appConfig.appColors.errorColor ?? "#FF1100"),
      lightGrey: HexColor(
          controller.configs?.appConfig.appColors.lightGrey ?? "#cccbc8"),
    );
    themeData.value = theme;
    setAppTheme(theme);
  }
}

void setAppTheme(ThemeDataModel theme) {
  final appTheme = ThemeData(
    primaryColor: theme.primaryColor,
    scaffoldBackgroundColor: theme.backgroundColor,
    cardColor: theme.whiteColor,
    textTheme: TextTheme(
      headlineMedium: TextStyle(color: theme.blackColor),
      labelMedium: TextStyle(color: theme.blackColor),
      bodyMedium: TextStyle(color: theme.primaryTextColor),
      bodySmall: TextStyle(color: theme.secondaryTextColor),
      titleMedium: TextStyle(color: theme.grayTextColor),
    ),
  );

  Get.changeTheme(appTheme);
}

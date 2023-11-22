import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/data/models/configs/configs.dart';
import 'package:get/get.dart';

class MasterDataHelper {
  MasterDataController controller = Get.find();
  AppColors? appColors;
  getMasterData() async{
    controller.readMasterData();
    if (controller.configs == null) {
      await controller.getMasterData();
    }
    appColors = AppColors(
      whiteColor: controller.configs!.appConfig.appColors.whiteColor,
      backgroundColor: controller.configs!.appConfig.appColors.backgroundColor,
      primaryColor: controller.configs!.appConfig.appColors.primaryColor,
      secondaryColor: controller.configs!.appConfig.appColors.secondaryColor,
      blackColor: controller.configs!.appConfig.appColors.blackColor,
      primaryTextColor:
          controller.configs!.appConfig.appColors.primaryTextColor,
      secondaryTextColor:
          controller.configs!.appConfig.appColors.secondaryTextColor,
      grayTextColor: controller.configs!.appConfig.appColors.grayTextColor,
      blackTextColor: controller.configs!.appConfig.appColors.blackTextColor,
      shadowColor: controller.configs!.appConfig.appColors.shadowColor,
      primaryGrayColor:
          controller.configs!.appConfig.appColors.primaryGrayColor,
      splashColor: controller.configs!.appConfig.appColors.splashColor,
      errorColor: controller.configs!.appConfig.appColors.errorColor,
      lightGrey: controller.configs!.appConfig.appColors.lightGrey,
    );
  }
}

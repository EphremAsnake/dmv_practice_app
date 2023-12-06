// ignore_for_file: must_be_immutable
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RefreshErrorWidget extends StatelessWidget {
  RefreshErrorWidget(
      {Key? key,
      required this.onRefresh,
      required this.errorMessage,
      required this.assetImage})
      : super(key: key);

  final themeData = Get.find<ThemeController>().themeData.value;

  Future<void> Function() onRefresh;
  String errorMessage;
  String assetImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              assetImage,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                errorMessage,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: themeData?.primaryColor,
                    fontSize:
                        SizerUtil.deviceType == DeviceType.mobile ? 14.sp : 16.sp,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Scroll to Refresh',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: themeData?.blackColor.withOpacity(0.4),
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 16.sp,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

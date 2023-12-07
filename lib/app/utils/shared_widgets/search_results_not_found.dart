import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SearchResultsNotFoundCard extends StatelessWidget {
  String message;
  SearchResultsNotFoundCard({Key? key, required this.message})
      : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: themeData!.grayTextColor, width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      borderOnForeground: false,
      color: themeData!.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'No Matching Results Found :(',
              style: TextStyle(
                color: themeData?.blackColor,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 9.sp,
              ),
            ),
          ),
          subtitle: Text(
            message,
            style: TextStyle(
              color: themeData?.grayTextColor,
              fontSize:
                  SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 8.sp,
            ),
          ),
          trailing: Icon(
            Icons.search_off_rounded,
            size: 17.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

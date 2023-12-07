import 'package:drivingexam/app/core/shared_controllers/search_controller.dart';
import 'package:drivingexam/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChange;
  final SearchBarController controller = Get.find();
  final themeData = Get.find<ThemeController>().themeData.value;

  CustomSearchBar({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      child: Center(
        child: TextField(
          // focusNode: FocusNode(),
          controller: controller.controller,
          style: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 7.sp,
            color: themeData!.primaryColor,
          ),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: themeData!.whiteColor,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: themeData!.lightGrey,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: themeData!.lightGrey,
                width: 1,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            hintText: controller.defaultSearchLabel,
            hintStyle: TextStyle(
              color: themeData!.blackColor,
              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 7.sp,
            ),
            labelText: controller.defaultSearchLabel,
            labelStyle: TextStyle(
              color: themeData!.blackColor,
              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 7.sp,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              size: SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 10.sp,
              color: themeData!.grayTextColor,
            ),
            suffixIcon: Visibility(
              visible: controller.isClearIconVisible.value,
              child: IconButton(
                onPressed: controller.clearSearch,
                icon: Icon(
                  Icons.clear,
                  size:
                      SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 13.sp,
                  color: themeData!.grayTextColor,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: themeData!.primaryColor,
                width: 1,
              ),
            ),
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}

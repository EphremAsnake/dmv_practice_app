import 'package:drivingexam/app/modules/home/controllers/home_controller.dart';
import 'package:drivingexam/app/utils/helper/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

class Settings extends StatelessWidget {
  Settings({
    super.key,
    required this.themeData,
  });

  final ThemeDataModel? themeData;
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "Settings",
              style: TextStyle(
                color: themeData?.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            Get.toNamed("/us-states");
          },
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text(
                "Change State",
                style: TextStyle(color: themeData?.grayTextColor),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: themeData?.grayTextColor,
              ),
              leading: Icon(
                Icons.flag_outlined,
                color: themeData?.grayTextColor,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text(
                "Randomize Questions",
                style: TextStyle(color: themeData?.grayTextColor),
              ),
              trailing: Obx(
                () => CupertinoSwitch(
                  activeColor: themeData!.primaryColor,
                  value: controller.isRandomizeQuestions.value,
                  onChanged: (state) {
                    controller.toggleRandomizingQuestion(state);
                  },
                ),
              ),
              leading: LineIcon.random(
                color: themeData?.grayTextColor,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text(
                "Auto Scrolling",
                style: TextStyle(color: themeData?.grayTextColor),
              ),
              trailing: Obx(
                () => CupertinoSwitch(
                  activeColor: themeData!.primaryColor,
                  value: controller.isAutoScrollingEnabled.value,
                  onChanged: (state) {
                    controller.toggleAutoScrollingBehavior(state);
                  },
                ),
              ),
              leading: LineIcon.scroll(
                color: themeData?.grayTextColor,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text(
                "Share",
                style: TextStyle(color: themeData?.grayTextColor),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: themeData?.grayTextColor,
              ),
              leading: Icon(
                Icons.share_outlined,
                color: themeData?.grayTextColor,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed("/about");
          },
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text(
                "About",
                style: TextStyle(color: themeData?.grayTextColor),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: themeData?.grayTextColor,
              ),
              leading: Icon(
                Icons.info_outline,
                color: themeData?.grayTextColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

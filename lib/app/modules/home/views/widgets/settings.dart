import 'package:drivingexam/app/modules/home/controllers/home_controller.dart';
import 'package:drivingexam/app/utils/helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

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
          child: Text(
            "Settings",
            style: TextStyle(
              color: themeData?.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
          child: const Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text("Change State"),
              trailing: Icon(Icons.chevron_right),
              leading: Icon(Icons.flag_outlined),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed("/about");
          },
          child: const Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text("About"),
              trailing: Icon(Icons.chevron_right),
              leading: Icon(Icons.info_outline),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: Text("Share"),
              trailing: Icon(Icons.chevron_right),
              leading: Icon(Icons.share_outlined),
            ),
          ),
        ),
        //  bool isAutoScrollEnabled = false;

        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            child: ListTile(
              title: const Text("Auto Scrolling"),
              trailing: SizedBox(
                height: 40,
                child: Obx(() => LiteRollingSwitch(
                      width: 90,
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                      value: controller.isAutoScrollingEnabled.value,
                      textOn: 'On',
                      textOff: 'Off',
                      colorOn: themeData!.primaryColor,
                      colorOff: themeData!.errorColor,
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      textSize: 14.0,
                      textOffColor: themeData!.whiteColor,
                      textOnColor: themeData!.whiteColor,
                      onChanged: (bool state) {
                        controller.toggleAutoScrollingBehavior(state);
                      },
                    )),
              ),
              leading: const Icon(Icons.play_arrow_outlined),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

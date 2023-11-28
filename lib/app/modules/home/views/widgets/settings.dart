
import 'package:drivingexam/app/utils/helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
    required this.themeData,
  });

  final ThemeDataModel? themeData;

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
              title: Text("Share "),
              trailing: Icon(Icons.chevron_right),
              leading: Icon(Icons.share_outlined),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
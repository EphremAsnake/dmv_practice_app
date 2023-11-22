import 'dart:async';

import 'package:drivingexam/app/core/core_dependency.dart';
import 'package:drivingexam/app/core/shared_controllers/master_data_controller.dart';
import 'package:drivingexam/app/utils/helper/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  final internetConnectivity = InternetConnectivity();
  await internetConnectivity.initialize();
  await Hive.initFlutter();
  await Hive.openBox('driving_exam');
  //injecting http dependency
  CoreDependencyCreator.init();
  
  //fetching master data
  MasterDataController masterDataController = Get.put(MasterDataController());
  masterDataController.getMasterData();

  // Set the app to be in portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //set the status bar color to transparent
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF016A70),
    ));

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Driving Exam",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}

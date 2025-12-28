import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/app.dart';
import 'package:gokul_ramk/features/user/notification/controller/user_notification_controller.dart';
import 'package:gokul_ramk/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NotificationController(),permanent: true);

  configEasyLoading();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // only if firebase_options.dart exists
  );
  runApp(const MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.grey
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

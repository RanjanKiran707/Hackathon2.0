import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/mainController.dart';

import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/pages.dart/onboarding_page.dart';

void main() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MainController mainController = Get.put(MainController());
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}

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
  MyApp({Key? key}) : super(key: key);
  final MainController mainController = Get.put(MainController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      title: 'PregTo',
      home: LoginPage(),
    );
  }
}

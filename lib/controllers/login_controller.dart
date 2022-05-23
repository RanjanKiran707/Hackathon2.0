import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/mainController.dart';
import 'package:todo/pages.dart/activity_page.dart';

class LoginController extends GetxController {
  final email = "".obs;
  final password = "".obs;

  final MainController _mainController = Get.find<MainController>();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void loginButtonPress() {
    if (_areFieldsValid()) {
      _mainController.signIn(emailCtrl.text, passCtrl.text).then((value) {
        if (value == "Signed In") {
          emailCtrl.clear();
          passCtrl.clear();
          Get.offAll(
            () => ActivityPage(),
            transition: Transition.leftToRightWithFade,
            duration: const Duration(milliseconds: 400),
            opaque: false,
            curve: Curves.easeOut,
          );
        } else {
          Get.snackbar("Error", value);
        }
      });
    }
  }

  Future googleLoginPress() async {
    final result = await _mainController.googleLogin();
    if (result) {
      Get.offAll(
        () => ActivityPage(),
        transition: Transition.leftToRightWithFade,
        duration: const Duration(milliseconds: 400),
        opaque: false,
        curve: Curves.easeOut,
      );
    } else {
      Get.snackbar("Error", "Google Sign In Failed");
    }
  }

  bool _areFieldsValid() {
    if (!GetUtils.isEmail(emailCtrl.text)) {
      Get.snackbar("Email Error", "Email is in invalid format");
      return false;
    }
    if (!GetUtils.isLengthGreaterOrEqual(passCtrl.text, 4)) {
      Get.snackbar("Password Error", "Password Length should be greater than 4");
      return false;
    }
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  bool _areFieldsValid() {
    if (!GetUtils.isEmail(emailCtrl.text)) {
      Get.snackbar("Email Error", "Email is in invalid format");
      return false;
    }
    if (!GetUtils.isLengthGreaterOrEqual(passCtrl.text, 4)) {
      Get.snackbar("Password Error", "Password Length should be greater than 4");
      return false;
    }

    if (!GetUtils.isLengthGreaterOrEqual(nameCtrl.text, 4)) {
      Get.snackbar("Name Error", "Name Length should be greater than 4");
      return false;
    }

    if (ageCtrl.text.isEmpty) {
      Get.snackbar("Age Error", "Age is empty");
      return false;
    }
    return true;
  }
}

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/mainController.dart';
import 'package:todo/domain/services/authenticate_service.dart';

class SignUpController extends GetxController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final MainController _mainController = Get.find<MainController>();

  Future signUp(BuildContext context) async {
    if (_areFieldsValid()) {
      final response = await _mainController.post(
        api: ApiConstants.register,
        body: {
          "name": nameCtrl.text,
          "age": num.parse(ageCtrl.text),
          "email": emailCtrl.text,
          "password": passCtrl.text,
        },
      );
      if (response.body != null) {
        await CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Success",
          text: response.body,
        );
        Get.back();
      } else {
        await CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          text: response.exception,
        );
      }
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

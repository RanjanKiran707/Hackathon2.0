import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/mainController.dart';
import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/pages.dart/activity_page.dart';
import 'package:todo/pages.dart/home_page.dart';

class LoginController extends GetxController {
  final email = "".obs;
  final password = "".obs;

  final MainController _mainController = Get.find<MainController>();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  Future loginButtonPress() async {
    if (_areFieldsValid()) {
      final response = await _mainController.post(
        api: ApiConstants.login,
        body: {
          "email": emailCtrl.text,
          "password": passCtrl.text,
        },
      );
      debugPrint(response.body);
      if (response.body != null) {
        Get.put(HomePage());
      } else {
        Get.snackbar("Error", response.exception.toString());
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
    return true;
  }
}

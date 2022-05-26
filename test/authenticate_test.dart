import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/controllers/mainController.dart';
import 'package:todo/domain/services/authenticate_service.dart';

void main() {
  test('Login', () async {
    print("Starting");
    MainController mainController = MainController();
    Map<String, dynamic> det = {
      "email": "asdnjk@mga.com",
      "password": "nasdkjl",
    };
    final res = await mainController.post(
      api: ApiConstants.login,
      body: det,
    );

    print(res.body);
  });
}

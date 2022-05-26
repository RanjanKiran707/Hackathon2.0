import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/domain/entities/calloutcome.dart';
import 'package:todo/domain/services/authenticate_service.dart';

class MainController extends GetxController {
  late AuthenticateService _authenticateService;

  @override
  void onInit() {
    _authenticateService = AuthenticateService();
    super.onInit();
  }

  Future<CallOutcome> post({required String api, required Map<String, dynamic> body}) async {
    try {
      final res = await _authenticateService.postRequest(api: api, body: body);
      debugPrint(res.body);
      if (res.statusCode == 200) {
        return CallOutcome(body: res.body, statusCode: res.statusCode);
      } else {
        return CallOutcome(exception: res.body, statusCode: res.statusCode);
      }
    } on Exception catch (e) {
      return CallOutcome(exception: e.toString(), statusCode: 500);
    }
  }
}

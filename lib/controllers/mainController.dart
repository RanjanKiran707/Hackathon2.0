import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/domain/entities/calloutcome.dart';
import 'package:todo/domain/services/authenticate_service.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  Future<http.Response> _postRequest({required String api, required Map<String, dynamic> body}) async {
    debugPrint("URl -> " + Uri.parse(ApiConstants.baseUrl + api).toString());
    debugPrint("Body -> " + jsonEncode(body));
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final http.Response res = await http.post(
      Uri.parse(ApiConstants.baseUrl + api),
      body: jsonEncode(body),
      headers: headers,
    );
    return res;
  }

  Future<CallOutcome> post({required String api, required Map<String, dynamic> body}) async {
    try {
      final res = await _postRequest(api: api, body: body);
      debugPrint(res.statusCode.toString());

      if (res.statusCode == 200) {
        return CallOutcome(body: res.body, statusCode: res.statusCode);
      } else {
        return CallOutcome(exception: res.body, statusCode: res.statusCode);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return CallOutcome(exception: e.toString(), statusCode: 500);
    }
  }
}

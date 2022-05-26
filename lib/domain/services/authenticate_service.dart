import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticateService {
  AuthenticateService();

  Future<http.Response> postRequest({required String api, required Map<String, dynamic> body}) async {
    debugPrint(Uri.parse(ApiConstants.baseUrl + api).toString());
    final http.Response res = await http.post(
      Uri.parse(ApiConstants.baseUrl + api),
      body: jsonEncode(body),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );
    debugPrint(res.statusCode.toString());
    return res;
  }
}

class ApiConstants {
  static String baseUrl = "https://hackbites.herokuapp.com/";
  static String register = "auth/register";
  static String login = "auth/login";
  static String details = "details";
}

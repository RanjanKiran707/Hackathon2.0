import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:todo/domain/entities/calloutcome.dart';

import '../domain/services/authenticate_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

class ApiService {
  Future<http.Response> _getRequest({
    required String api,
    required Map<String, dynamic> queryParams,
  }) async {
    debugPrint("URl -> " + Uri.parse(ApiConstants.baseUrl + api).toString());
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final http.Response res = await http.get(
      Uri.parse(ApiConstants.baseUrl + api)
          .replace(queryParameters: queryParams),
      headers: headers,
    );
    return res;
  }

  Future<CallOutcome> get({
    required String api,
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      final res = await _getRequest(api: api, queryParams: queryParams);
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

  Future<http.Response> _postRequest({
    required String api,
    required Map<String, dynamic> body,
    Map<String, dynamic> queryParams = const {},
  }) async {
    debugPrint("URl -> " + Uri.parse(ApiConstants.baseUrl + api).toString());
    debugPrint("Body -> " + jsonEncode(body));
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final http.Response res = await http.post(
      Uri.parse(ApiConstants.baseUrl + api)
          .replace(queryParameters: queryParams),
      body: jsonEncode(body),
      headers: headers,
    );
    return res;
  }

  Future<CallOutcome> post({
    required String api,
    required Map<String, dynamic> body,
    Map<String, dynamic> queryParams = const {},
  }) async {
    try {
      final res =
          await _postRequest(api: api, body: body, queryParams: queryParams);
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

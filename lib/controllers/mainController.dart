import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/domain/services/authenticate_service.dart';

class MainController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late AuthenticateService _authenticateService;
  final signedIn = true.obs;

  @override
  void onInit() {
    _authenticateService = AuthenticateService(_firebaseAuth);
    super.onInit();
  }

  Future<String> signIn(String email, String password) {
    return _authenticateService.signIn(
      email: email,
      password: password,
    );
  }

  Future<String> signUp(String email, String password) {
    return _authenticateService.signUp(email: email, password: password);
  }

  Future<bool> googleLogin() {
    return _authenticateService.googleLogin();
  }
}

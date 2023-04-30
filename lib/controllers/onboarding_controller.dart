import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/pages.dart/login_page.dart';

class OnBoardingController extends GetxController {
  final List<String> text = [
    "Stay Always in touch with your doctor",
    "Schedule an appointment the easy way",
    "Push the SOS button to get help",
    "Use the pregnancy knowledge base to learn more.",
  ];

  final index = 0.obs;

  String getText() {
    return text[index.value];
  }

  void floatingPress() {
    if (index.value < text.length - 1) {
      index.value++;
      return;
    }
    if (index.value == text.length - 1) {
      Get.to(
        LoginPage(),
        duration: const Duration(milliseconds: 600),
      );
    }
  }
}

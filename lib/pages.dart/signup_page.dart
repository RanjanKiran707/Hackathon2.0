import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/signup_controller.dart';
import 'package:todo/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(SignUpController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SignUp",
              style: bigheading,
            ),
            30.heightBox,
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                      size: 20,
                    ),
                    15.widthBox,
                    Expanded(
                      child: TextField(
                        controller: ctrl.emailCtrl,
                        cursorColor: Colors.white,
                        style: subHeading2,
                        decoration: InputDecoration(
                          hintText: "Email ID",
                          hintStyle: subHeading2,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                16.heightBox,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.lock_open_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    14.widthBox,
                    Expanded(
                      child: TextField(
                        controller: ctrl.passCtrl,
                        obscureText: true,
                        style: subHeading2,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: subHeading2,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                16.heightBox,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.lock_open_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    14.widthBox,
                    Expanded(
                      child: TextField(
                        controller: ctrl.nameCtrl,
                        obscureText: true,
                        style: subHeading2,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: subHeading2,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                16.heightBox,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.lock_open_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    14.widthBox,
                    Expanded(
                      child: TextField(
                        controller: ctrl.ageCtrl,
                        obscureText: true,
                        style: subHeading2,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "Age",
                          hintStyle: subHeading2,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

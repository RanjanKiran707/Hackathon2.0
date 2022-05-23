import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo/colors.dart';
import 'package:todo/controllers/login_controller.dart';
import 'package:todo/fonts.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController homeController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(
              flex: 2,
            ),
            Text(
              "Login",
              style: bigheading,
            ),
            30.heightBox,
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.alternate_email,
                      color: lightGrey,
                      size: 20,
                    ),
                    15.widthBox,
                    Expanded(
                      child: TextField(
                        controller: homeController.emailCtrl,
                        cursorColor: lightGrey,
                        style: subHeading2,
                        decoration: InputDecoration(
                          hintText: "Email ID",
                          hintStyle: subHeading2,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey),
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
                    Icon(
                      Icons.lock_open_outlined,
                      color: lightGrey,
                      size: 20,
                    ),
                    14.widthBox,
                    Expanded(
                      child: TextField(
                        controller: homeController.passCtrl,
                        obscureText: true,
                        style: subHeading2,
                        cursorColor: lightGrey,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: subHeading2,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            20.heightBox,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => debugPrint("Forgot Password"),
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.varelaRound(
                    color: blueColor,
                  ),
                ),
              ),
            ),
            20.heightBox,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      homeController.loginButtonPress();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Login",
                        style: subHeading,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              children: [
                Expanded(
                  child: Divider(color: lightGrey, thickness: 0.5),
                ),
                20.widthBox,
                Text("OR", style: subHeading),
                20.widthBox,
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: lightGrey,
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      homeController.googleLoginPress();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/images/google-color.svg",
                            height: 20,
                          ),
                          Text(
                            "Login with Google",
                            style: subHeading.copyWith(
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: const Color(0xFFf0f4f6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "New here?",
                        style: GoogleFonts.varelaRound(color: lightGrey),
                      ),
                      TextSpan(
                        text: " Register",
                        style: GoogleFonts.varelaRound(color: blueColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("Clicked Register");
                          },
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? s) {
    if (s!.isNotEmpty && s.contains("@") && s.contains(".") && !s.contains(" ")) {
      return null;
    } else {
      return "Invalid Email Format";
    }
  }

  String? _validatePassword(String? s) {
    if (s!.isNotEmpty && s.length > 4) {
      return null;
    } else {
      return "Length should be greater than 4";
    }
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo/colors.dart';
import 'package:todo/controllers/login_controller.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/signup_page.dart';
import 'package:todo/utils/loadingButton.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginctrl = Get.put(LoginController());
    return Scaffold(
      backgroundColor: primary,
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
                    const Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                      size: 20,
                    ),
                    15.widthBox,
                    Expanded(
                      child: TextField(
                        controller: loginctrl.emailCtrl,
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
                        controller: loginctrl.passCtrl,
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
                    color: secondary,
                  ),
                ),
              ),
            ),
            20.heightBox,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: LoadingButton(
                    fontSize: 18,
                    onPressed: loginctrl.loginButtonPress,
                    text: "Login",
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              children: [
                const Expanded(
                  child: Divider(color: primary, thickness: 0.5),
                ),
                20.widthBox,
                Text("OR", style: subHeading),
                20.widthBox,
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: primary,
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
                      Get.to(SignUpPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SignUp",
                            style: subHeading.copyWith(
                              color: Colors.black45,
                            ),
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

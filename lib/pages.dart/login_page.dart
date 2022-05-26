import 'package:flutter/material.dart';
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
                CustomTextField(ctrl: loginctrl.emailCtrl, name: "Email", icon: Icons.email),
                16.heightBox,
                CustomTextField(ctrl: loginctrl.passCtrl, name: "Password", icon: Icons.lock),
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
                    color: secondary,
                    fontSize: 18,
                    onPressed: () => loginctrl.loginButtonPress(context),
                    text: "Login",
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              children: [
                const Expanded(
                  child: Divider(color: Colors.white, thickness: 0.5),
                ),
                20.widthBox,
                Text("OR", style: subHeading),
                20.widthBox,
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: LoadingButton(
                    color: Colors.grey,
                    fontSize: 18,
                    onPressed: () async {
                      Get.to(const SignUpPage());
                    },
                    text: "Sign Up",
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

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo/colors.dart';
import 'package:todo/controllers/login_controller.dart';
import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/nav_page.dart';
import 'package:todo/pages.dart/signup_page.dart';
import 'package:todo/repository_providers.dart/post_repo.dart';
import 'package:todo/state_providers/login_provider.dart';
import 'package:todo/utils/loadingButton.dart';
import 'package:todo/utils/snackbars.dart';

import 'package:velocity_x/velocity_x.dart';

import '../utils/navigator.dart';

final StateProvider loginDetailsProvider = StateProvider((ref) => {});

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool _areFieldsValid(BuildContext context) {
    if (!GetUtils.isEmail(emailCtrl.text)) {
      Snack.showSnackBar(context, "Email Error : Email is in invalid format");
      return false;
    }
    if (!GetUtils.isLengthGreaterOrEqual(passCtrl.text, 4)) {
      Snack.showSnackBar(
          context, "Password Error" "Password Length should be greater than 4");
      return false;
    }
    return true;
  }

  Future loginButtonPress(
      BuildContext context, ApiService postService, WidgetRef ref) async {
    if (_areFieldsValid(context)) {
      final response = await postService.post(
        api: ApiConstants.login,
        body: {
          "email": emailCtrl.text,
          "password": passCtrl.text,
        },
      );
      debugPrint(response.body);
      if (response.body != null) {
        ref.read(loginDetailsProvider.notifier).state = {
          "email": emailCtrl.text,
        };
        Nav.push(context, const NavPage());
      } else {
        await CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          text: response.statusCode.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                CustomTextField(
                    ctrl: emailCtrl, name: "Email", icon: Icons.email),
                16.heightBox,
                CustomTextField(
                    ctrl: passCtrl, name: "Password", icon: Icons.lock),
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
            LoadingButton(
              color: secondary,
              fontSize: 18,
              onPressed: () {
                return loginButtonPress(
                    context, ref.read(apiServiceProvider), ref);
              },
              text: "Login",
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
            LoadingButton(
              color: Colors.grey,
              fontSize: 18,
              onPressed: () async {
                Nav.push(context, SignUpPage());
              },
              text: "Sign Up",
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

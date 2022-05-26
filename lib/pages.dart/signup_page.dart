import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/colors.dart';
import 'package:todo/controllers/signup_controller.dart';
import 'package:todo/fonts.dart';
import 'package:todo/utils/loadingButton.dart';
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
                CustomTextField(ctrl: ctrl.emailCtrl, name: "Email", icon: Icons.email),
                16.heightBox,
                CustomTextField(ctrl: ctrl.passCtrl, name: "Password", icon: Icons.lock),
                16.heightBox,
                CustomTextField(ctrl: ctrl.nameCtrl, name: "Name", icon: Icons.person),
                16.heightBox,
                CustomTextField(ctrl: ctrl.ageCtrl, name: "Age", icon: Icons.numbers),
                20.heightBox,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: LoadingButton(
                        color: secondary,
                        fontSize: 16,
                        onPressed: ctrl.signUp,
                        text: "Sign Up",
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.ctrl,
    required this.name,
    required this.icon,
  }) : super(key: key);

  final TextEditingController ctrl;
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        14.widthBox,
        Expanded(
          child: TextField(
            controller: ctrl,
            obscureText: name == "Password" ? true : false,
            style: subHeading2,
            cursorColor: Colors.white,
            keyboardType: name != "Age" ? TextInputType.text : TextInputType.number,
            decoration: InputDecoration(
              hintText: name,
              hintStyle: subHeading2,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

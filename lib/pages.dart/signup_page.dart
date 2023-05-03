import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todo/colors.dart';
import 'package:todo/controllers/signup_controller.dart';
import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/repository_providers.dart/post_repo.dart';
import 'package:todo/utils/loadingButton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/navigator.dart';

final signUpIndex = StateProvider<int>((ref) => 0);

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  Future<void> signUp(WidgetRef ref, BuildContext context) async {
    final res = await ref.read(apiServiceProvider).post(
      api: ApiConstants.register,
      body: {
        "name": nameCtrl.text,
        "email": emailCtrl.text,
        "password": passCtrl.text,
        "age": ageCtrl.text,
      },
    );

    if (res.body != null) {
      ref.read(signUpIndex.notifier).state = 1;
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Error",
        text: "Something went wrong",
      );
    }
  }

  Future<void> addDetails(WidgetRef ref, BuildContext context) async {
    final res = await ref
        .read(apiServiceProvider)
        .post(api: ApiConstants.details, body: {
      "height": heightCtrl.text,
      "weight": weightCtrl.text,
      "pregnantDays": daysCtrl.text,
      "number": ageCtrl.text,
    }, queryParams: {
      "email": emailCtrl.text,
    });

    if (res.body != null) {
      Nav.push(context, LoginPage());
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Error",
        text: "Something went wrong",
      );
    }
  }

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();

  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  final daysCtrl = TextEditingController();
  final doctorCtrl = TextEditingController();
  final partnerCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final index = ref.watch(signUpIndex);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
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
                    16.heightBox,
                    CustomTextField(
                        ctrl: nameCtrl, name: "Name", icon: Icons.person),
                    16.heightBox,
                    CustomTextField(
                        ctrl: ageCtrl, name: "Age", icon: Icons.numbers),
                    20.heightBox,
                    LoadingButton(
                      color: secondary,
                      fontSize: 16,
                      onPressed: () => signUp(ref, context),
                      text: "Sign Up",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Details",
                  style: bigheading,
                ),
                30.heightBox,
                Column(
                  children: [
                    CustomTextField(
                        ctrl: heightCtrl,
                        name: "Height",
                        icon: Icons.boy_outlined),
                    16.heightBox,
                    CustomTextField(
                        ctrl: weightCtrl,
                        name: "Weight",
                        icon: Icons.monitor_weight),
                    16.heightBox,
                    CustomTextField(
                        ctrl: daysCtrl,
                        name: "Days Since Pregnant",
                        icon: Icons.pregnant_woman),
                    16.heightBox,
                    CustomTextField(
                        ctrl: partnerCtrl,
                        name: "Partner Number",
                        icon: Icons.phone),
                    20.heightBox,
                    LoadingButton(
                      color: secondary,
                      fontSize: 16,
                      onPressed: () => addDetails(ref, context),
                      text: "Add Details",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          color: Colors.grey,
          size: 20,
        ),
        14.widthBox,
        Expanded(
          child: TextField(
            controller: ctrl,
            obscureText: name == "Password" ? true : false,
            style: subHeading2,
            cursorColor: Colors.white,
            keyboardType:
                name != "Age" ? TextInputType.text : TextInputType.number,
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

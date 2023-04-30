import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:todo/colors.dart';
import 'package:todo/controllers/onboarding_controller.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/utils/navigator.dart';
import 'package:velocity_x/velocity_x.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int index = 0;

  final List<String> text = [
    "Stay Always in touch with your doctor",
    "Schedule an appointment the easy way",
    "Push the SOS button to get help",
    "Use the pregnancy knowledge base to learn more.",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    if (index < text.length - 1) {
                      index++;
                      setState(() {});
                      return;
                    }
                    if (index == text.length - 1) {
                      Nav.push(context, LoginPage());
                    }
                  } else {
                    if (index >= 1) {
                      index -= 1;
                      setState(() {});
                    }
                  }
                },
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      fillColor: primary,
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                    );
                  },
                  child: Container(
                    key: UniqueKey(),
                    color: primary,
                    child: Column(
                      children: [
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: text[index].text.textStyle(bigheading).make(),
                        ),
                        20.heightBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Dots(index: index),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (index < text.length - 1) {
                      index++;
                      setState(() {});
                      return;
                    }
                    if (index == text.length - 1) {
                      Nav.push(context, LoginPage());
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                  backgroundColor: secondary,
                ),
              ],
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}

class Dots extends StatelessWidget {
  const Dots({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [0, 1, 2, 3]
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Get.find<OnBoardingController>().index.value = e;
                },
                child: CircleAvatar(
                  backgroundColor: index == e ? secondary : Colors.grey,
                  radius: 7,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

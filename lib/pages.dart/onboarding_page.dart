import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:todo/colors.dart';
import 'package:todo/controllers/onboarding_controller.dart';
import 'package:todo/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnBoardingController ctrl = Get.put(OnBoardingController());
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < 0) {
                      ctrl.floatingPress();
                    } else {
                      if (ctrl.index.value >= 1) {
                        ctrl.index.value -= 1;
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
                            child: ctrl.getText().text.textStyle(bigheading).color(Colors.white).make(),
                          ),
                          20.heightBox,
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            Row(
              children: [
                Obx(() => Dots(index: ctrl.index.value)),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ctrl.floatingPress,
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
                  backgroundColor: index == e ? secondary : Colors.white,
                  radius: 7,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

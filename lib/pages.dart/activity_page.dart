import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/colors.dart';
import 'package:todo/controllers/activity_controller.dart';
import 'package:todo/controllers/login_controller.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatelessWidget {
  final ActivityController homeController = Get.put(ActivityController());
  ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 50, 18, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back,",
                      style: bodyText.copyWith(
                        color: lightGrey,
                      ),
                    ),
                    5.heightBox,
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email!.split("@")[0],
                      style: subHeading,
                    )
                  ],
                ),
                const Spacer(),
                Text(homeController.formatter1.format(DateTime.now())),
                6.widthBox,
                const Icon(
                  Icons.calendar_month,
                ),
              ],
            ),
            20.heightBox,
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx(
                  () => GestureDetector(
                    onTap: () => homeController.changeSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 50,
                      decoration: BoxDecoration(
                        border: DateTime.now().weekday - 1 == index ? Border.all(color: Colors.black, width: 1) : null,
                        borderRadius: BorderRadius.circular(10.0),
                        color: homeController.selected.value == index ? lightBlue : Colors.white30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          homeController.dayNames[index].dayName.text
                              .textStyle(bodyText)
                              .color(homeController.selected.value == index ? Colors.white : lightGrey)
                              .make(),
                          homeController.dayNames[index].dayNum
                              .toString()
                              .text
                              .textStyle(bodyText)
                              .color(homeController.selected.value == index ? Colors.white : lightGrey)
                              .make(),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => 10.widthBox,
                itemCount: 7,
              ),
            ),
            10.heightBox,
            Expanded(
              child: PageView.builder(
                controller: homeController.pageController,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.red[100 * (index + 1)],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: "Add New Activity".text.make(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(13.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

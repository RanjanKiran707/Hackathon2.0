import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final homeData = ref.watch(homeDataProvider);

    return homeData.when(
      data: (data) {
        return Scaffold(
            appBar: AppBar(
              title: "Profile Page"
                  .text
                  .textStyle(bigheading.copyWith(color: Colors.white))
                  .make(),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    title: "Name".text.make(),
                    trailing: data["name"].toString().text.make(),
                  ),
                  10.heightBox,
                  ListTile(
                    onTap: () {},
                    title: "Email".text.make(),
                    trailing: data["email"].toString().text.make(),
                  ),
                  10.heightBox,
                  ListTile(
                    onTap: () {},
                    title: "Age".text.make(),
                    trailing: data["age"].toString().text.make(),
                  ),
                  10.heightBox,
                  ListTile(
                    onTap: () {},
                    title: "PID".text.make(),
                    trailing: data["pid"].toString().text.make(),
                  ),
                  10.heightBox,
                  ListTile(
                    onTap: () {},
                    title: "Body Mass Index".text.make(),
                    trailing: data["bmi"].toString().text.make(),
                  ),
                  10.heightBox,
                  ListTile(
                    onTap: () {},
                    title: "Days Since Pregnant".text.make(),
                    trailing: data["daysSincePregnant"].toString().text.make(),
                  ),
                ],
              ),
            ));
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => "$err".text.makeCentered(),
    );
  }
}

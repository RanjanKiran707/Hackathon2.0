import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/repository_providers.dart/post_repo.dart';
import 'package:todo/utils/loadingButton.dart';

final homeDataProvider = StateProvider((ref) => const AsyncValue.loading());

final mealPlanProvider = StateProvider((ref) => const AsyncValue.loading());

final appointmentStateProvider =
    StateProvider((ref) => CrossFadeState.showFirst);
final selectedWeekProvider = StateProvider((ref) => 0);

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  final doctor = TextEditingController();
  final dateCtrl = TextEditingController();

  Future<void> _getMealData(WidgetRef ref, BuildContext context) async {
    final res = await ref.read(apiServiceProvider).get(
      api: ApiConstants.getMealPlan,
      queryParams: {
        "email": ref.read(loginDetailsProvider)["email"],
      },
    );
    if (res.body != null) {
      debugPrint("Response = " + res.body.toString());
      ref.read(mealPlanProvider.notifier).state =
          AsyncValue.data(jsonDecode(res.body!));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Error",
        text: "Something went wrong",
      );
      ref.read(mealPlanProvider.notifier).state =
          AsyncValue.error("Error", StackTrace.current);
    }
  }

  Future<void> _getData(WidgetRef ref, BuildContext context) async {
    final res = await ref.read(apiServiceProvider).get(
      api: ApiConstants.getDetails,
      queryParams: {
        "email": ref.read(loginDetailsProvider)["email"],
      },
    );
    if (res.body != null) {
      debugPrint("Response = " + res.body.toString());
      ref.read(selectedWeekProvider.notifier).state =
          (jsonDecode(res.body!)["daysSincePregnant"] / 7).toInt();
      ref.read(homeDataProvider.notifier).state =
          AsyncValue.data(jsonDecode(res.body!));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Error",
        text: "Something went wrong",
      );
      ref.read(homeDataProvider.notifier).state =
          AsyncValue.error("Error", StackTrace.current);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeDataProvider);

    return homeState.when<Widget>(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            leading: null,
            title: Text("Welcome ${data["name"]}"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  ref.read(homeDataProvider.notifier).state = AsyncLoading();
                },
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  ref.read(homeDataProvider.notifier).state = AsyncLoading();
                  ref.read(mealPlanProvider.notifier).state = AsyncLoading();
                },
                icon: const Icon(Icons.sos),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  "Next Appointment".text.textStyle(subHeading).make(),
                  20.heightBox,
                  Consumer(
                    builder: (context, ref, child) {
                      final crossFadeState =
                          ref.watch(appointmentStateProvider);
                      return AppointmentsWidget(
                        doctor: doctor,
                        dateCtrl: dateCtrl,
                        crossFadeState: crossFadeState,
                      );
                    },
                  ),
                  10.heightBox,
                  "What to Expect".text.textStyle(subHeading).make(),
                  WeekNumWidget(data: data),
                  10.heightBox,
                  Consumer(builder: (context, ref, child) {
                    final selIndex = ref.watch(selectedWeekProvider);
                    return TrimesterWidget(selIndex: selIndex);
                  }),
                  20.heightBox,
                  "Examination Details".text.textStyle(subHeading).make(),
                  10.heightBox,
                  Consumer(builder: (context, ref, child) {
                    final selIndex = ref.watch(selectedWeekProvider);
                    final map = data["tracker"].firstWhere(
                      (map) => map["week"] == selIndex + 1,
                      orElse: () => {},
                    );
                    return ExaminationWidget(map: map, selIndex: selIndex);
                  }),
                  Consumer(
                    builder: (context, ref, child) {
                      final mealPlan = ref.watch(mealPlanProvider);

                      return mealPlan.when(
                        data: (data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.heightBox,
                              "Meal Plan".text.textStyle(subHeading).make(),
                              10.heightBox,
                              data["plan"]
                                  .toString()
                                  .text
                                  .textStyle(bodyText)
                                  .make(),
                            ],
                          );
                        },
                        loading: () {
                          _getMealData(ref, context);
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        error: (err, _) => err.toString().text.make(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (err, _) => const CircularProgressIndicator(),
      loading: () {
        _getData(ref, context);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ExaminationWidget extends StatelessWidget {
  const ExaminationWidget({
    Key? key,
    required this.map,
    required this.selIndex,
  }) : super(key: key);
  final Map map;
  final int selIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                "Blood Pressure".text.textStyle(subHeading2).make(),
                10.heightBox,
                map["bp"] != null
                    ? map["bp"].toString().text.textStyle(subHeading).make()
                    : "Not Available".text.textStyle(subHeading).make(),
                30.heightBox,
                "Heart Rate".text.textStyle(subHeading2).make(),
                10.heightBox,
                map["heart"] != null
                    ? map["heart"].toString().text.textStyle(subHeading).make()
                    : "Not Available".text.textStyle(subHeading).make(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                "Weight".text.textStyle(subHeading2).make(),
                10.heightBox,
                map["weight"] != null
                    ? map["weight"].toString().text.textStyle(subHeading).make()
                    : "Not Available".text.textStyle(subHeading).make(),
                30.heightBox,
                "Temperature".text.textStyle(subHeading2).make(),
                10.heightBox,
                map["temperature"] != null
                    ? map["heart"].toString().text.textStyle(subHeading).make()
                    : "Not Available".text.textStyle(subHeading).make(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrimesterWidget extends StatelessWidget {
  const TrimesterWidget({
    Key? key,
    required this.selIndex,
  }) : super(key: key);

  final int selIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.heart_broken,
            size: 100,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child:
                          "Week ${selIndex + 1} - ${calculateTrimester(selIndex + 1)}"
                              .text
                              .textStyle(subHeading)
                              .align(TextAlign.center)
                              .makeCentered(),
                    ),
                  ],
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        "Avg Size".text.make(),
                        5.heightBox,
                        "${calculateAverageSize(selIndex + 1)}cm".text.make(),
                      ],
                    ),
                    10.widthBox,
                    Column(
                      children: [
                        "Avg Weight".text.make(),
                        5.heightBox,
                        "${calculateAverageWeight(selIndex + 1)}g".text.make(),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeekNumWidget extends StatelessWidget {
  const WeekNumWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selIndex = ref.watch(selectedWeekProvider);
      return SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 40,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                ref.read(selectedWeekProvider.notifier).state = index;
              },
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  color: data["daysSincePregnant"] / 7 >= index
                      ? Colors.blueAccent[200]
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: selIndex == index
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.1,
                  ),
                ),
                child: "${index + 1}"
                    .text
                    .color(
                      data["daysSincePregnant"] / 7 >= index
                          ? Colors.white
                          : Colors.black,
                    )
                    .makeCentered(),
              ),
            );
          },
        ),
      );
    });
  }
}

class AppointmentsWidget extends ConsumerWidget {
  const AppointmentsWidget({
    Key? key,
    required this.doctor,
    required this.dateCtrl,
    required this.crossFadeState,
  }) : super(key: key);

  final TextEditingController doctor;
  final TextEditingController dateCtrl;
  final CrossFadeState crossFadeState;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1.1,
        ),
      ),
      child: AnimatedCrossFade(
        firstChild: Row(
          children: [
            const Text("Add Appointment"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:
                          "Add Appointment".text.textStyle(subHeading2).make(),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: doctor,
                            decoration:
                                const InputDecoration(labelText: "Doctor Name"),
                          ),
                          TextField(
                            controller: dateCtrl,
                            decoration: const InputDecoration(
                              labelText: "Date",
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );
                              if (date != null) {
                                dateCtrl.text = date.toString().split(" ")[0];
                              }
                            },
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ref
                                .read(appointmentStateProvider.notifier)
                                .update((state) => CrossFadeState.showSecond);
                          },
                          child: "Add".text.make(),
                        )
                      ],
                    );
                  },
                );
              },
              child: const Text("Add"),
            )
          ],
        ),
        secondChild: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                ),
                10.widthBox,
                doctor.text.text.textStyle(subHeading2).make(),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 30,
                ),
                10.widthBox,
                dateCtrl.text.text.textStyle(subHeading2).make(),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(appointmentStateProvider.notifier)
                        .update((state) => CrossFadeState.showFirst);
                  },
                  child: const Text("Finish"),
                )
              ],
            ),
          ],
        ),
        crossFadeState: crossFadeState,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}

String calculateTrimester(int week) {
  if (week >= 1 && week <= 12) {
    return 'First Trimester';
  } else if (week >= 13 && week <= 24) {
    return 'Second Trimester';
  } else if (week >= 25 && week <= 40) {
    return 'Third Trimester';
  } else {
    return 'Invalid Week Number';
  }
}

double calculateAverageSize(int week) {
  final size = (week * 0.03) + 0.7;
  return size.toPrecision(2);
}

double calculateAverageWeight(int week) {
  final weight = (week * 0.0175) + 0.2;
  return weight.toPrecision(2);
}

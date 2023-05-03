import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/utils/loadingButton.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/repository_providers.dart/post_repo.dart';

final foodDataProvider = StateProvider((ref) => const AsyncValue.loading());

final tabIndexFoodProvider = StateProvider((ref) => 0);

class FoodPage extends ConsumerWidget {
  const FoodPage({Key? key}) : super(key: key);

  _getFoodData(WidgetRef ref) async {
    final serv = ref.read(apiServiceProvider);

    final res1 = await serv
        .get(api: ApiConstants.getFood, queryParams: {"ayurvedic": "true"});
    final res2 = await serv.get(api: ApiConstants.getFood, queryParams: {});
    if (res1.body != null && res2.body != null) {
      ref.read(foodDataProvider.notifier).state = AsyncValue.data({
        "ayurvedic": jsonDecode(res1.body.toString()),
        "normal": jsonDecode(res2.body.toString())
      });
    } else {
      ref.read(foodDataProvider.notifier).state =
          AsyncValue.error("Error", StackTrace.current);
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final foodData = ref.watch(foodDataProvider);
    return foodData.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: "Food Page"
                .text
                .textStyle(bigheading.copyWith(color: Colors.white))
                .make(),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Column(
                children: [
                  TabBar(
                    onTap: (value) {
                      ref.read(tabIndexFoodProvider.notifier).state = value;
                    },
                    tabs: const [
                      Tab(
                        text: "Normal",
                      ),
                      Tab(
                        text: "Ayurvedic",
                      )
                    ],
                  ),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, _) {
                        final index = ref.watch(tabIndexFoodProvider);
                        return IndexedStack(
                          index: index,
                          children: [
                            FoodListWidget(
                                list: List<Map>.from(data["normal"])),
                            FoodListWidget(
                                list: List<Map>.from(data["ayurvedic"]))
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      error: (err, stk) {
        return Center(
          child: err.toString().text.make(),
        );
      },
      loading: () {
        _getFoodData(ref);
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class FoodListWidget extends ConsumerWidget {
  const FoodListWidget({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<Map> list;

  Future<void> addOrder(
      WidgetRef ref, Map selected, BuildContext context) async {
    final serv = ref.read(apiServiceProvider);

    final res = await serv.post(
      api: ApiConstants.addOrder,
      body: {
        "name": selected["meal"],
        "quantity": selected["quantity"],
      },
      queryParams: {
        "email": ref.read(loginDetailsProvider)["email"],
      },
    );
    if (res.body != null) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: "Success Order Place",
        text: res.body.toString(),
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Error",
        text: res.exception.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      child: Column(
        children: list.map(
          (e) {
            return Container(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  Image.network(
                    e["url"],
                    width: 100,
                    height: 100,
                  ),
                  10.heightBox,
                  e["meal"].toString().text.textStyle(subHeading).make(),
                  10.heightBox,
                  e["info"].toString().text.textStyle(bodyText).make(),
                  10.heightBox,
                  LoadingButton(
                    onPressed: () async {
                      await addOrder(ref, e, context);
                    },
                    text: "Order Now",
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

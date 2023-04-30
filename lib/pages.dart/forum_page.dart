import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/pages.dart/food_page.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/repository_providers.dart/post_repo.dart';
import 'package:todo/utils/loadingButton.dart';
import 'package:velocity_x/velocity_x.dart';

final forumDataProvider = StateProvider((ref) => const AsyncValue.loading());

class ForumPage extends ConsumerWidget {
  const ForumPage({Key? key}) : super(key: key);

  Future<void> getAllQs(WidgetRef ref) async {
    final serv = ref.read(apiServiceProvider);
    final res = await serv.get(api: ApiConstants.getAllQ, queryParams: {});
    if (res.body != null) {
      ref.read(forumDataProvider.notifier).state =
          AsyncValue.data(jsonDecode(res.body.toString()));
    } else {
      ref.read(forumDataProvider.notifier).state =
          AsyncValue.error("Error", StackTrace.current);
    }
  }

  Future<void> askAQuestion(WidgetRef ref, BuildContext context) async {
    final serv = ref.read(apiServiceProvider);
    final questionController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: "Ask a question".text.make(),
        content: TextField(
          controller: questionController,
          decoration: InputDecoration(
            hintText: "Enter your question here",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: "Cancel".text.make(),
          ),
          TextButton(
            onPressed: () async {
              if (questionController.text.isNotEmpty) {
                final res = await serv.post(api: ApiConstants.addQ, body: {
                  "question": questionController.text,
                }, queryParams: {
                  "email": ref.read(loginDetailsProvider)["email"],
                });
                if (res.body != null) {
                  Navigator.pop(context);
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: "Success",
                    text: "Question added successfully",
                  );
                } else {
                  Navigator.pop(context);
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: "Error",
                    text: "Error adding question",
                  );
                }
              } else {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  title: "Error",
                  text: "Please enter a question",
                );
              }
            },
            child: "Ask".text.make(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final forumData = ref.watch(forumDataProvider);

    // write forumData when function
    return forumData.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: "Forum".text.make(),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(forumDataProvider.notifier).state =
                      AsyncValue.loading();
                },
                icon: Icon(Icons.refresh),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              askAQuestion(ref, context);
            },
            label: "Ask a question".text.make(),
            icon: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      final ctrl = TextEditingController();
                      return ExpansionTile(
                        title: item["question"].toString().text.make(),
                        children: [
                          ...item["answers"]
                              .map<Widget>(
                                (e) => ListTile(
                                  title: Text(e["answer"]),
                                ),
                              )
                              .toList(),
                          15.heightBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: ctrl,
                              decoration: InputDecoration(
                                hintText: "Enter your answer",
                              ),
                              onSubmitted: (value) async {},
                            ),
                          ),
                          10.heightBox,
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: LoadingButton(
                              text: "Add Answer",
                              color: Colors.lightBlueAccent,
                              onPressed: () async {
                                final serv = ref.read(apiServiceProvider);
                                final res = await serv.post(
                                  api: ApiConstants.addAns,
                                  queryParams: {
                                    "user": "Anon",
                                    "id": item["_id"],
                                  },
                                  body: {
                                    "answer": ctrl.text,
                                  },
                                );
                                ctrl.clear();
                                if (res.body != null) {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: "Answer added",
                                  );
                                } else {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: "Error",
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () {
        getAllQs(ref);
        return const Center(child: CircularProgressIndicator());
      },
      error: (err, stack) => Center(
        child: Text(err.toString()),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:todo/domain/services/authenticate_service.dart';
import 'package:todo/fonts.dart';
import 'package:todo/pages.dart/login_page.dart';
import 'package:todo/repository_providers.dart/post_repo.dart';
import 'package:todo/utils/loadingButton.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import "package:youtube_player_flutter/youtube_player_flutter.dart" as yt;

final workoutDataProvider = StateProvider((ref) => AsyncValue.loading());

class WorkoutPage extends ConsumerWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  Future<void> _getWorkData(WidgetRef ref) async {
    final apiServ = ref.read(apiServiceProvider);

    final res = await apiServ.get(
      api: ApiConstants.getEx,
      queryParams: {"email": ref.read(loginDetailsProvider)["email"]},
    );

    if (res.body != null) {
      debugPrint(res.body!);
      ref.read(workoutDataProvider.notifier).state =
          AsyncValue.data(jsonDecode(res.body!));
    } else {
      ref.read(workoutDataProvider.notifier).state = AsyncValue.error(
        "Error",
        StackTrace.current,
      );
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final workoutData = ref.watch(workoutDataProvider);
    return workoutData.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: "Exercises"
                .text
                .textStyle(bigheading.copyWith(color: Colors.white))
                .make(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: data.map<Widget>(
                (e) {
                  return Container(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YoutubeWidget(
                          url: e["link"],
                        ),
                        10.heightBox,
                        e["title"].toString().text.textStyle(subHeading).make(),
                        10.heightBox,
                        e["info"].toString().text.textStyle(bodyText).make(),
                        10.heightBox,
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
      loading: () {
        _getWorkData(ref);
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}

class YoutubeWidget extends StatefulWidget {
  const YoutubeWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<YoutubeWidget> createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidget> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: yt.YoutubePlayer.convertUrlToId(widget.url)!,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Column(
          children: [
            SizedBox(
              height: context.screenHeight * 0.4,
              child: player,
            ),
            Text('Youtube Player'),
          ],
        );
      },
    );
  }
}

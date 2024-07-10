import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/feed_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class CustomPodPlayer extends StatefulWidget {
  final String url;
  const CustomPodPlayer({
    super.key,
    required this.url,
  });

  @override
  State<CustomPodPlayer> createState() => _CustomPodPlayerState();
}

class _CustomPodPlayerState extends State<CustomPodPlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.url),
        ));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
  // final activePlayerController = Get.find<ActivePlayerController>();

  // @override
  // void initState() {
  //   super.initState();

  // playerController = PodPlayerController(
  //     playVideoFrom: PlayVideoFrom.network(widget.url,
  //         videoPlayerOptions: VideoPlayerOptions()),
  //     podPlayerConfig: PodPlayerConfig(autoPlay: false))
  //   ..initialise().then((value) {
  //     playerController.hideOverlay();
  //   activePlayerController.setActivePlayer(playerController);

  //   setState(() {});
  // })
  // ..addListener(() {
  //   if (playerController.isVideoPlaying) {
  //     if (playerController != activePlayerController.activePlayer) {
  //       activePlayerController.pauseActive();
  //       activePlayerController.setActivePlayer(playerController);
  //     }
  //   }
  // });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // playerController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return FeedPlayer(
      url: widget.url,
    );
  }
}


import 'package:alibtisam_flutter/features/commons/events/controller/active_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

class CustomPodPlayer extends StatefulWidget {
  final bool? showOptions;
  final String url;
  const CustomPodPlayer({
    super.key,
    required this.url,
    this.showOptions,
  });

  @override
  State<CustomPodPlayer> createState() => _CustomPodPlayerState();
}

class _CustomPodPlayerState extends State<CustomPodPlayer> {
  late PodPlayerController playerController;
  final activePlayerController = Get.find<ActivePlayerController>();

  @override
  void initState() {
    super.initState();

    playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.url,
            videoPlayerOptions: VideoPlayerOptions()),
        podPlayerConfig: PodPlayerConfig(autoPlay: false))
      ..initialise().then((value) {
        playerController.hideOverlay();
        activePlayerController.setActivePlayer(playerController);

        setState(() {});
      })
      ..addListener(() {
        if (playerController.isVideoPlaying) {
          if (playerController != activePlayerController.activePlayer) {
            activePlayerController.pauseActive();
            activePlayerController.setActivePlayer(playerController);
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomPodPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    playerController.pause();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showOptions ?? true
        ? PodVideoPlayer(
            matchVideoAspectRatioToFrame: true,
            controller: playerController,
            frameAspectRatio: 20 / 28,
          )
        : PodVideoPlayer(
            overlayBuilder: (options) {
              return Text('');
            },
            matchVideoAspectRatioToFrame: true,
            controller: playerController,
            frameAspectRatio: 20 / 28,
          );
  }
}

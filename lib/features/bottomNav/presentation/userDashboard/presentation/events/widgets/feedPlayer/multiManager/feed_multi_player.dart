import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_manager.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_player_potrait_controls.dart';

import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class FlickMultiPlayer extends StatefulWidget {
  final String type;
  const FlickMultiPlayer(
      {Key? key,
      required this.url,
      this.image,
      required this.flickMultiManager,
      required this.type})
      : super(key: key);

  final String url;
  final String? image;
  final FlickMultiManager flickMultiManager;

  @override
  _FlickMultiPlayerState createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(widget.url))
            ..setLooping(true),
      autoPlay: false,
    );
    widget.flickMultiManager.init(flickManager);

    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.9) {
          widget.flickMultiManager.play(flickManager);
        }
      },
      child: Container(
        child: widget.type == 'image'
            ? Image.network(
                widget.url,
                fit: BoxFit.cover,
                height: Get.height,
              )
            : FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  playerLoadingFallback: Positioned.fill(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Positioned(
                            child: Image.asset(
                              widget.image!,
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controls: FeedPlayerPortraitControls(
                    flickMultiManager: widget.flickMultiManager,
                    flickManager: flickManager,
                  ),
                ),
                flickVideoWithControlsFullscreen: FlickVideoWithControls(
                  playerLoadingFallback: Center(
                      child: Image.network(
                    widget.image!,
                    fit: BoxFit.fitWidth,
                  )),
                  controls: FlickLandscapeControls(),
                  iconThemeData: IconThemeData(
                    size: 40,
                    color: Colors.white,
                  ),
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
      ),
    );
  }
}

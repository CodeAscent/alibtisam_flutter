import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_manager.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FeedPlayer extends StatefulWidget {
  final String url;
  final bool? showControls;
  FeedPlayer({Key? key, required this.url, this.showControls = false})
      : super(key: key);

  @override
  _FeedPlayerState createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickMultiManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickMultiManager.pause();
        }
      },
      child: FlickMultiPlayer(
        url: widget.url,
        flickMultiManager: flickMultiManager,
        showControls: widget.showControls,
      ),
    );
  }
}

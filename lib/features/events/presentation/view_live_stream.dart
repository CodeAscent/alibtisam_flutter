// ignore_for_file: deprecated_member_use

import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/events/model/events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewLiveStream extends StatefulWidget {
  final Events event;
  const ViewLiveStream({super.key, required this.event});

  @override
  State<ViewLiveStream> createState() => _ViewLiveStreamState();
}

class _ViewLiveStreamState extends State<ViewLiveStream> {
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;
  late PlayerState _playerState;
  bool _isPlayerReady = false;
  bool _muted = false;
  late TextEditingController _seekToController;
  late TextEditingController _idController;

  @override
  void initState() {
    super.initState();
    getVId();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;

        print(
            "Player State: $_playerState"); // Add this line to debug player state
      });
    }
  }

  String vId = '';
  getVId() async {
    print('Stream URL: ${widget.event.streamUrl}');
    final Uri uri = Uri.parse(widget.event.streamUrl);
    vId = uri.queryParameters['v'] ?? '';
    print('Video ID: $vId'); // Log the video ID
    if (vId.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: vId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          isLive: true,
        ),
      )..addListener(listener);

      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.value.isFullScreen) {
          _controller.toggleFullScreenMode();
          await Future.delayed(Duration(milliseconds: 300));
          return false;
        } else {
          return true;
        }
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          liveUIColor: primaryColor(),
          progressIndicatorColor: primaryColor(),
          progressColors: ProgressBarColors(playedColor: primaryColor()),
          showVideoProgressIndicator: true,
          onReady: () async {
            await Future.delayed(Duration(seconds: 7));
            _isPlayerReady = true;
            setState(() {});
          },
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: _controller.value.isFullScreen
                ? null
                : AppBar(
                    title: Text('Live Stream'),
                  ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: _isPlayerReady,
                  replacement: Stack(
                    children: [
                      player,
                      Container(
                        height: 250,
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  child: player,
                ),
                Visibility(
                  visible: !_controller.value.isFullScreen,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Category: ${widget.event.category}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Date & Time: ${customDateTimeFormat(widget.event.dateTime)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Location: ${widget.event.location}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Description: ${widget.event.description}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

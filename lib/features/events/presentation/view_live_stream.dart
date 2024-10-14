// ignore_for_file: deprecated_member_use

import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/events/model/events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';

class ViewLiveStream extends StatefulWidget {
  final Events event;
  const ViewLiveStream({super.key, required this.event});

  @override
  State<ViewLiveStream> createState() => _ViewLiveStreamState();
}

class _ViewLiveStreamState extends State<ViewLiveStream> {
  late final PodPlayerController _controller;

  bool _isPlayerReady = false;
  late TextEditingController _seekToController;
  late TextEditingController _idController;

  @override
  void initState() {
    super.initState();
    getVId();
  }

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;

  //       print(
  //           "Player State: $_playerState"); // Add this line to debug player state
  //     });
  //   }
  // }

  String vId = '';
  getVId() async {
    print('Stream URL: ${widget.event.streamUrl}');
    final Uri uri = Uri.parse(widget.event.streamUrl);
    vId = uri.queryParameters['v'] ?? '';
    print('Video ID: $vId'); // Log the video ID
    if (vId.isNotEmpty) {
      _controller = PodPlayerController(
        playVideoFrom:
            PlayVideoFrom.youtube(widget.event.streamUrl, live: true),
        // flags: YoutubePlayerFlags(
        //   autoPlay: true,
        //   isLive: true,
        // ),
      )..initialise();
      // ..addListener(listener);

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
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PodVideoPlayer(
              controller: _controller,
              podPlayerLabels: const PodPlayerLabels(
                play: "Play label customized",
                pause: "Pause label customized",
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        ],
      ),
    ));
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:alibtisam/client/socket_io.dart';
import 'package:alibtisam/core/services/video_download.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final File? videoFile;
  final bool sending;
  final String? groupId;
  final String? videoUrl;

  const VideoPreview({
    super.key,
    this.videoFile,
    required this.sending,
    this.groupId,
    this.videoUrl,
  });

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController videoPlayerController;
  bool isPlaying = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller based on whether it's a local file or a URL
    if (widget.sending) {
      videoPlayerController =
          VideoPlayerController.file(File(widget.videoFile!.path));
    } else {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
    }

    // Add listener to update the state when the video player controller changes
    videoPlayerController.addListener(() {
      setState(() {
        isPlaying = videoPlayerController.value.isPlaying;
        isLoading = videoPlayerController.value.isBuffering;
      });
    });

    // Initialize the video player
    videoPlayerController.initialize().then((_) {
      setState(() {
        isLoading = false; // Video is ready to play
      });
    });
  }

  @override
  void dispose() {
    // Dispose the video player controller to free up resources
    videoPlayerController.dispose();
    super.dispose();
  }

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'.tr),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isPlaying) {
                              videoPlayerController.pause();
                            } else {
                              videoPlayerController.play();
                            }
                          });
                        },
                        child: VideoPlayer(videoPlayerController)),
                  ),
                  VideoProgressIndicator(
                    videoPlayerController,
                    allowScrubbing: true,
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          setState(() {
                            if (isPlaying) {
                              videoPlayerController.pause();
                            } else {
                              videoPlayerController.play();
                            }
                          });
                        },
                      ),
                      Text(
                        '${_formatDuration(videoPlayerController.value.position)} / ${_formatDuration(videoPlayerController.value.duration)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: Visibility(
        visible: widget.sending,
        replacement: FloatingActionButton(
          onPressed: () async {
            MediaDownloader().downloadMedia(widget.videoUrl!);
          },
          child: Icon(CupertinoIcons.cloud_download),
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final bytes = await widget.videoFile!.readAsBytes();

            final base64String = base64Encode(bytes);

            SocketConnection.sendMessage(
              uid: userController.user!.id!,
              message: '',
              groupId: widget.groupId!,
              file: base64String,
              type: 'video',
            );
            Get.back();
          },
          child: Icon(CupertinoIcons.share),
        ),
      ),
    );
  }

  // Format the duration to show minutes and seconds
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

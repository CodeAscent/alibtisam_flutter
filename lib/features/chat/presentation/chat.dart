import 'dart:convert';
import 'dart:io';

import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/chat/controller/chat_messages.dart';
import 'package:alibtisam/features/chat/presentation/image_preview.dart';
import 'package:alibtisam/features/chat/presentation/video_preview.dart';
import 'package:alibtisam/features/enrollment/views/pages/external_enrollment_form.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:alibtisam/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/chat/presentation/chat_about.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/client/socket_io.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/view_members.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ChatScreen extends StatefulWidget {
  final String groupId;
  final String name;

  const ChatScreen({
    super.key,
    required this.groupId,
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final themeController = Get.find<ThemeController>();
  final userController = Get.find<UserController>();
  final groupsController = Get.find<GroupsController>();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    SocketConnection.joinChat(widget.groupId, _scrollToBottom);
    SocketConnection.listenMessages(_scrollToBottom);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SocketConnection.clearListeners();
    super.dispose();
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool showFileSelection = false;
  Future<void> pickAndSendVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final fileSize = File(result.files.single.path!);
      final fileLength = fileSize.lengthSync(); // Get the file size in bytes

      if (fileLength > 20 * 1024 * 1024) {
        customSnackbar(
            'Please select a video under 20 MB.', ContentType.failure);
        return;
      }

      if (file.path != null) {
        final videoFile = File(file.path!);
        try {
          setState(() {
            showFileSelection = false;
          });

          Get.to(() => VideoPreview(
                sending: true,
                groupId: widget.groupId,
                videoFile: videoFile,
              ));
        } catch (e) {
          print("Error reading file: $e");
        }
      }
    }
  }

  pickAndSendImage() async {
    final image = await pickImageFromGalary();

    if (image != null) {
      setState(() {
        showFileSelection = false;
      });
      Get.to(() => ImagePreview(
            sending: true,
            imageFile: File(image.path),
            groupId: widget.groupId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showFileSelection) {
          setState(() {
            showFileSelection = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Get.to(() => ViewGroupMembers(
                    canUpdate:
                        userController.user!.role == 'COACH' ? true : false,
                  ));
            },
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(child: Text(widget.name.capitalize!)),
              ],
            ),
          ),
        ),
        body: GetBuilder<ChatMessagesController>(
          init: ChatMessagesController(),
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        ...List.generate(controller.messages.length,
                            (int index) {
                          ChatMessages message = controller.messages[index];
                          bool showDate = true;

                          if (index > 0) {
                            DateTime previousDate = DateTime.parse(
                                controller.messages[index - 1].updatedAt!);
                            showDate = !_isSameDate(
                                DateTime.parse(message.updatedAt!),
                                previousDate);
                          }

                          return Column(
                            crossAxisAlignment:
                                message.senderId == userController.user!.id
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              if (showDate)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      customChatDateFormat(message.updatedAt!),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      String name = '';
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(name),
                                      );
                                    },
                                  ),
                                  // Image Bubble
                                  message.type == 'image'
                                      ? kCustomChatBubble(
                                          message,
                                          context,
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => ImagePreview(
                                                    sending: false,
                                                    imageUrl: message.mediaUrl,
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                kSenderName(message),
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: message.mediaUrl!,
                                                    fit: BoxFit.cover,
                                                    height: 140,
                                                    width: 200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      // Video Bubble
                                      : message.type == 'video'
                                          ? GestureDetector(
                                              onTap: () {
                                                Get.to(() => VideoPreview(
                                                      sending: false,
                                                      videoUrl:
                                                          message.mediaUrl,
                                                    ));
                                              },
                                              child: kCustomChatBubble(
                                                message,
                                                context,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    kSenderName(message),
                                                    VisibilityDetector(
                                                        key: Key(
                                                            'video-${message.mediaUrl}'),
                                                        onVisibilityChanged:
                                                            (visibilityInfo) {
                                                          if (visibilityInfo
                                                                      .visibleFraction >
                                                                  0.5 &&
                                                              !visibilityInfo
                                                                  .visibleFraction
                                                                  .isNaN) {
                                                            controller
                                                                .loadThumbnailFor(
                                                                    message);
                                                          }
                                                        },
                                                        child: FutureBuilder(
                                                          future: controller
                                                              .getThumbnail(
                                                                  message
                                                                      .mediaUrl),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    child: Image
                                                                        .file(
                                                                      File(snapshot
                                                                          .data!),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          140,
                                                                      width:
                                                                          200,
                                                                    ),
                                                                  ),
                                                                  Positioned
                                                                      .fill(
                                                                    child: Icon(
                                                                      CupertinoIcons
                                                                          .play,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 30,
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                            return SizedBox(
                                                              height: 140,
                                                              width: 200,
                                                            );
                                                          },
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          // Text Bubble
                                          : kCustomChatBubble(
                                              message,
                                              context,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  kSenderName(message),
                                                  Text(
                                                    message.content!,
                                                    style: TextStyle(
                                                        color: message
                                                                    .senderId! ==
                                                                userController
                                                                    .user!.id!
                                                            ? Colors.white
                                                            : null),
                                                  ),
                                                ],
                                              ),
                                            ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text(
                                    customChatTimeFormat(message.updatedAt!)),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 10),
                        Obx(() => controller.meesageSending.value
                            ? Text('Sending...')
                            : SizedBox()),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: showFileSelection
                                    ? Container(
                                        height: 200, // Dynamic height change
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),

                                        child: Column(
                                          children: [
                                            Text(
                                              'Pick File',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    pickAndSendImage();
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                          primaryColor(),
                                                      child: Text(
                                                        'Image',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                ),
                                                SizedBox(width: 20),
                                                GestureDetector(
                                                  onTap: () async {
                                                    pickAndSendVideo();
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                          primaryColor(),
                                                      child: Text(
                                                        'Video',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 50)
                                          ],
                                        ),
                                      )
                                    : TextFormField(
                                        controller: messageController,
                                        maxLength: null,
                                        onFieldSubmitted: (value) {
                                          if (messageController.text.trim() !=
                                              '') {
                                            SocketConnection.sendMessage(
                                              uid: userController.user!.id!,
                                              message:
                                                  messageController.text.trim(),
                                              groupId: widget.groupId,
                                              file: null,
                                              type: 'text',
                                            );
                                          }
                                          _scrollToBottom();
                                          messageController.clear();
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  showFileSelection = true;
                                                });
                                              },
                                              icon: Icon(Icons.attach_file)),
                                          hintText: 'typeYourMessage'.tr,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (messageController.text.trim() != '') {
                                    SocketConnection.sendMessage(
                                      uid: userController.user!.id!,
                                      message: messageController.text.trim(),
                                      groupId: widget.groupId,
                                      file: null,
                                      type: 'type',
                                    );
                                  }
                                  _scrollToBottom();
                                  messageController.clear();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: primaryColor(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ChatBubble kCustomChatBubble(
      ChatMessages message, BuildContext context, Widget child) {
    return ChatBubble(
        clipper: ChatBubbleClipper1(
            type: message.senderId == userController.user!.id
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble),
        alignment: message.senderId == userController.user!.id
            ? Alignment.topRight
            : Alignment.topLeft,
        margin: EdgeInsets.only(
            top: 20,
            left: message.senderId == userController.user!.id ? 100 : 0,
            right: message.senderId != userController.user!.id ? 100 : 0),
        backGroundColor: message.senderId == userController.user!.id
            ? primaryColor()
            : Color(0xffE7E7ED),
        child: child);
  }

  Visibility kSenderName(ChatMessages message) {
    return Visibility(
      visible: message.senderId != userController.user!.id,
      child: Text(
        message.senderName.toString(),
        style: TextStyle(
            height: 2, fontWeight: FontWeight.w800, color: primaryColor()),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:alibtisam/features/bottomNav/controller/chat_messages.dart';
import 'package:alibtisam/features/enrollment/views/pages/external_enrollment_form.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:alibtisam/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/chat/chat_about.dart';
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
import 'package:path_provider/path_provider.dart';

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
      print('File size: ${fileSize.lengthSync()} bytes');

      // Check if file path is valid
      if (file.path != null) {
        final videoFile = File(file.path!);
        try {
          final bytes = await videoFile.readAsBytes();

          final base64String = base64Encode(bytes);

          setState(() {
            showFileSelection = false;
          });

          // Sending the message via socket
          SocketConnection.sendMessage(
            uid: userController.user!.id!,
            message: '',
            groupId: widget.groupId,
            file: base64String,
            type: 'video',
          );
        } catch (e) {
          print("Error reading file: $e");
        }
      } else {
        print("File path is null.");
      }
    } else {
      print("No file selected");
    }
  }

  Future generateThumbnail(String videoUrl) async {
    dynamic fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ...List.generate(controller.messages.length, (int index) {
                        ChatMessages message = controller.messages[index];
                        bool showDate = true;

                        if (index > 0) {
                          DateTime previousDate = DateTime.parse(
                              controller.messages[index - 1].updatedAt!);
                          showDate = !_isSameDate(
                              DateTime.parse(message.updatedAt!), previousDate);
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
                                    // for (var participant
                                    //     in groupsController.me.) {
                                    //   if (participant.id == message.senderId &&
                                    //       message.senderId !=
                                    //           userController.user!.id) {
                                    //     name = participant.name!;
                                    //   }
                                    // }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(name),
                                    );
                                  },
                                ),
                                message.type == 'image'
                                    ? ChatBubble(
                                        clipper: ChatBubbleClipper1(
                                            type: BubbleType.sendBubble),
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(top: 20),
                                        backGroundColor: Colors.blue,
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
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
                                      )
                                    : message.type == 'video'
                                        ? ChatBubble(
                                            clipper: ChatBubbleClipper1(
                                                type: BubbleType.sendBubble),
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(top: 20),
                                            backGroundColor: Colors.blue,
                                            child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7,
                                                ),
                                                child: FutureBuilder(
                                                  future: generateThumbnail(
                                                      message.mediaUrl!),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Image.file(
                                                        File(snapshot.data!),
                                                        fit: BoxFit.cover,
                                                        height: 140,
                                                        width: 200,
                                                      );
                                                    }
                                                    return SizedBox(
                                                      height: 140,
                                                      width: 200,
                                                    );
                                                  },
                                                )),
                                          )
                                        : ChatBubble(
                                            clipper: ChatBubbleClipper1(
                                                type: BubbleType.sendBubble),
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(top: 20),
                                            backGroundColor: Colors.blue,
                                            child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7,
                                                ),
                                                child: Text(message.content!)),
                                          ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                  customChatTimeFormat(message.updatedAt!)),
                            ),
                            SizedBox(height: 10)
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
                // visible: !controller.meesageSending.value,
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
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Pick File',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    final image =
                                                        await pickImageFromGalary();
                                                    final bytes = await image
                                                        ?.readAsBytes(); // Get bytes from file

                                                    final base64Image =
                                                        base64Encode(bytes!);

                                                    if (image != null) {
                                                      setState(() {
                                                        showFileSelection =
                                                            false;
                                                      });
                                                      SocketConnection
                                                          .sendMessage(
                                                        uid: userController
                                                            .user!.id!,
                                                        message: '',
                                                        groupId: widget.groupId,
                                                        file: base64Image,
                                                        type: 'image',
                                                      );
                                                    }
                                                  },
                                                  icon: Icon(Icons.file_copy)),
                                              IconButton(
                                                  onPressed: () async {
                                                    pickAndSendVideo();
                                                  },
                                                  icon: Icon(Icons.file_copy))
                                            ],
                                          )
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
                                            onPressed: () {
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
    );
  }
}

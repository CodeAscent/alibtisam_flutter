import 'package:alibtisam/features/bottomNav/controller/chat_messages.dart';
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
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

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
              //   ClipRRect(
              //     borderRadius: BorderRadius.circular(160),
              //     child: Image.network(
              //       widget.image,
              //       height: 40,
              //       width: 40,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
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
                              controller.messages[index - 1].updatedAt);
                          showDate = !_isSameDate(
                              DateTime.parse(message.updatedAt), previousDate);
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
                                    customChatDateFormat(message.updatedAt),
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
                                BubbleSpecialThree(
                                  text: message.content,
                                  color: message.senderId ==
                                          userController.user!.id
                                      ? primaryColor()
                                      : kAppGreyColor(),
                                  tail: true,
                                  isSender: message.senderId ==
                                      userController.user!.id,
                                  textStyle: TextStyle(
                                    color: message.senderId ==
                                                userController.user!.id ||
                                            themeController.isDarkTheme()
                                        ? Colors.white
                                        : null,
                                    //flutter run --enable-impeller
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child:
                                  Text(customChatTimeFormat(message.updatedAt)),
                            ),
                            SizedBox(height: 10)
                          ],
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              maxLength: null,
                              onFieldSubmitted: (value) {
                                if (messageController.text.trim() != '') {
                                  SocketConnection.sendMessage(
                                    uid: userController.user!.id!,
                                    message: messageController.text.trim(),
                                    groupId: widget.groupId,
                                  );
                                }
                                _scrollToBottom();
                                messageController.clear();
                              },
                              decoration: InputDecoration(
                                hintText: 'typeYourMessage'.tr,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
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
            ],
          );
        },
      ),
    );
  }
}

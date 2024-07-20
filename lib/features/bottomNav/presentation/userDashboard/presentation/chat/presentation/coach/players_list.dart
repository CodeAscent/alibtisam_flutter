import 'package:alibtisam/features/bottomNav/controller/chats_list.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/custom_chat_cards.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerChatList extends StatelessWidget {
  const PlayerChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return GetBuilder(
      init: ChatsListController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ...List.generate(controller.chats.length, (int index) {
                  Chat chat = controller.chats[index];

                  return GestureDetector(onTap: () {
                    // Get.to(() => ChatScreen(
                    //           chatId: chat.id!,
                    //         ))!
                    //     .then((e) => SocketConnection.getNewChat());
                  }, child: Builder(
                    builder: (context) {
                      String chatName = '';
                      String profilePic = '';
                      if (!chat.isGroup!) {
                        for (var user in chat.participants!) {
                          if (user.id != userController.user!.id) {
                            chatName = user.name!;
                            profilePic = user.pic!;
                          }
                        }
                      } else {
                        chatName = chat.name!;
                        profilePic = chat.profilePic!;
                      }
                      return CustomChatCards(
                        label: chatName,
                        lastMessage: chat.lastMessage ?? '',
                        time: customChatTimeFormat(chat.updatedAt ?? ''),
                        image: profilePic,
                      );
                    },
                  ));
                })
              ],
            ),
          ),
        );
      },
    );
  }
}

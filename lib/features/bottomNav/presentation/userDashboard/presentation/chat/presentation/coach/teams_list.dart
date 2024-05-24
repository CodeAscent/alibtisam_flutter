import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/chat.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/custom_chat_cards.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamChatList extends StatelessWidget {
  const TeamChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...List.generate(5, (int index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => ChatScreen());
                },
                child: CustomChatCards(
                  label: 'Team name',
                  lastMessage:
                      "Last message: jdj ddj djjd djjdjdj djdjdjdjjnjdjdjdj  djj d",
                  time: customChatTimeFormat(DateTime.now().toString()),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

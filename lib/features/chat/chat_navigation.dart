import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/chat/presentation/coach/chat_stages.dart';
import 'package:alibtisam/features/chat/presentation/internal/player_chat_groups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatNavigation extends StatelessWidget {
  const ChatNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return userController.user!.role == "COACH"
        ? ChatStages()
        : PlayerChatGroups();
  }
}
//  : userController.user!.role == "GUARDIAN"
//             ? GuardianChat()

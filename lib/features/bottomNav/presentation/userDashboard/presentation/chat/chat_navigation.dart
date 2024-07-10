import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/chat.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/coach/coach_chat_teams_list.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/gaurdian/guardian_chat.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/internal/internal_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatNavigation extends StatelessWidget {
  const ChatNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return userController.user!.role == "COACH"
        ? CoachChatTeamList()
        : CoachChatTeamList();
  }
}
//  : userController.user!.role == "GUARDIAN"
//             ? GuardianChat()

import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/custom_chat_cards.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAbout extends StatefulWidget {
  const ChatAbout({super.key});

  @override
  State<ChatAbout> createState() => _ChatAboutState();
}

class _ChatAboutState extends State<ChatAbout> {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            collapsedHeight: 100,
            pinned: true,
            stretch: true,
            flexibleSpace: SafeArea(
                child: Image.network(
              userController.user!.pic,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ...List.generate(
                  //     12,
                  //     (int index) => CustomChatCards(
                  //         label: "Player name",
                  //         lastMessage: "lastMessage",
                  //         time:
                  //             customChatTimeFormat(DateTime.now().toString()),))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

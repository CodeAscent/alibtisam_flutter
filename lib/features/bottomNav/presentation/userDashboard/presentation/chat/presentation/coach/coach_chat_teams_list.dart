import 'package:alibtisam_flutter/client/socket_io.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/chats_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/chat.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/coach/players_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/coach/teams_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/custom_chat_cards.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_players_list.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachChatTeamList extends StatefulWidget {
  const CoachChatTeamList({super.key});

  @override
  State<CoachChatTeamList> createState() => _CoachChatTeamListState();
}

class _CoachChatTeamListState extends State<CoachChatTeamList>
    with TickerProviderStateMixin {
  late TabController _tabController;
  ChatsListController chatsListController = Get.find<ChatsListController>();
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    chatsListController.fetchChatsList();
    SocketConnection.getNewChat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text('chat'.tr),
        ),
        body: GetBuilder(
          init: ChatsListController(),
          builder: (controller) {
            return controller.chats.length == 0
                ? CustomEmptyWidget()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ...List.generate(controller.chats.length,
                              (int index) {
                            Chat chat = controller.chats[index];

                            return Builder(
                              builder: (context) {
                                String chatName = '';
                                String profilePic = '';
                                if (!chat.isGroup!) {
                                  for (var user in chat.participants!) {
                                    if (user.id != userController.user!.id) {
                                      chatName = user.name;
                                      profilePic = user.pic;
                                    }
                                  }
                                } else {
                                  chatName = chat.name!;
                                  profilePic = chat.profilePic!;
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ChatScreen(
                                          chatId: chat.id!,
                                          name: chatName,
                                          image: profilePic,
                                          chatInfo: chat,
                                        ));
                                  },
                                  child: CustomChatCards(
                                    label: chatName,
                                    lastMessage: chat.lastMessage ?? '',
                                    time: customChatTimeFormat(
                                        chat.updatedAt ?? ''),
                                    image: profilePic,
                                  ),
                                );
                              },
                            );
                          })
                        ],
                      ),
                    ),
                  );
          },
        ),

        // CustomTabBar(
        //   tabController: _tabController,
        //   customTabs: [
        //     Tab(text: "team".tr),
        //     Tab(
        //       text: "player".tr,
        //     )
        //   ],
        //   tabViewScreens: [TeamChatList(), PlayerChatList()],
        // ),
      ),
    );
  }
}

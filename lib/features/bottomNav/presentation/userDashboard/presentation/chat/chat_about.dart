import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/model/chats_list.dart';
import 'package:SNP/features/bottomNav/model/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/view_coach_profile.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/theme/app_colors.dart';
import 'package:SNP/core/utils/loading_manager.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAbout extends StatefulWidget {
  final String image;
  final Chat chat;
  final String name;
  const ChatAbout(
      {super.key, required this.image, required this.chat, required this.name});

  @override
  State<ChatAbout> createState() => _ChatAboutState();
}

class _ChatAboutState extends State<ChatAbout> {
  final UserController userController = Get.find<UserController>();
  checkUser() {
    if (!widget.chat.isGroup!) {
      for (var participant in widget.chat.participants!) {
        if (participant.id != userController.user!.id) {
          if (participant.role == 'INTERNAL USER') {
            return ViewPlayerByUserModel(player: participant);
          }
          return Scaffold(body: ViewCoachProfile(user: participant));
        }
      }
    }
    return ViewTeamProfile(widget: widget);
  }

  @override
  Widget build(BuildContext context) {
    return checkUser();
  }
}

class ViewTeamProfile extends StatelessWidget {
  const ViewTeamProfile({
    super.key,
    required this.widget,
  });

  final ChatAbout widget;

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              collapsedHeight: 150,
              stretch: true,
              pinned: true,
              flexibleSpace: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      ...List.generate(widget.chat.participants!.length,
                          (int index) {
                        return GestureDetector(
                            onTap: () async {
                              await LoadingManager.dummyLoading();
                              if (widget.chat.participants![index].role ==
                                  "COACH") {
                                Get.to(() => ViewCoachProfile(
                                      user: widget.chat.participants![index],
                                    ));
                              } else {
                                Get.to(() => ViewPlayerByUserModel(
                                    player: widget.chat.participants![index]));
                              }
                            },
                            child: Card(
                              child: SizedBox(
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(160),
                                          child: Image.network(
                                            widget
                                                .chat.participants![index].pic,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(widget
                                              .chat
                                              .participants![index]
                                              .name
                                              .capitalize!),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5)
                                  ],
                                ),
                              ),
                            )

                            // kCustomListTile(
                            //     key: "name".tr,
                            //     value: widget.chat.participants![index].name),
                            );
                      })
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Container kCustomListTile({required String key, required dynamic value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: kAppGreyColor(), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(key),
        subtitle: Text(
          value.toString().capitalize!,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}


import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/chat_about.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Get.to(() => ChatAbout());
            },
            child: Text("Team name or Player name")),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BubbleSpecialThree(
                    text: 'Added iMessage shape bubbles',
                    color: primaryColor(),
                    tail: false,
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  BubbleSpecialThree(
                    text: 'Please try and give some feedback on it!',
                    color: primaryColor(),
                    tail: true,
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  BubbleSpecialThree(
                    text: 'Sure',
                    color: kAppGreyColor(),
                    tail: false,
                    isSender: false,
                  ),
                  BubbleSpecialThree(
                    text: "I tried. It's awesome!!!",
                    color: kAppGreyColor(),
                    tail: false,
                    isSender: false,
                  ),
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
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.mic,
                    //       color: primaryColor(),
                    //     )),
                    Expanded(
                      child: TextFormField(
                        maxLength: null,
                        decoration: InputDecoration(
                            hintText: 'Type your message...',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: primaryColor(),
                        )),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

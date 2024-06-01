// import 'package:SNP/features/bottomNav/controller/chats_list.dart';
// import 'package:SNP/features/bottomNav/controller/user.dart';
// import 'package:SNP/features/bottomNav/model/chats_list.dart';
// import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/chat/chat.dart';
// import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/custom_chat_cards.dart';
// import 'package:SNP/helper/utils/custom_date_formatter.dart';
// import 'package:SNP/client/socket_io.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TeamChatList extends StatefulWidget {
//   const TeamChatList({
//     super.key,
//   });

//   @override
//   State<TeamChatList> createState() => _TeamChatListState();
// }

// class _TeamChatListState extends State<TeamChatList> {
//   final chatsListController = Get.find<ChatsListController>();
//   final userController = Get.find<UserController>();

//   @override
//   void initState() {
//     super.initState();
//     // SocketConnection.fetchChats(userController.user.id);
//     chatsListController.fetchChatsList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
// GetBuilder(
//       init: ChatsListController(),
//       builder: (controller) {
//         List<ChatsList> chats = controller.chats;

//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 ...List.generate(chats.length, (int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Get.to(() => ChatScreen(
//                             chatId: chats[index].id!,
//                           ));
//                     },
//                     child: 
// CustomChatCards(
//                       label: chats[index].participantDetails![0].name,
//                       lastMessage: chats[index].lastMessage ?? '',
//                       time: customChatTimeFormat(chats[index].updatedAt ?? ''),
//                       image: chats[index].participantDetails![0].pic,
//                     ),
//                   );
//                 })
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

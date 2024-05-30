import 'dart:convert';

import 'package:alibtisam_flutter/features/bottomNav/controller/chat_messages.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/chats_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/chat_message.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam_flutter/helper/localStorage/token_id.dart';
import 'package:alibtisam_flutter/network/api_urls.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnection {
  static final userController = Get.find<UserController>();
  static IO.Socket socket = IO.io(base_url, <String, dynamic>{
    'transports': ['websocket'],
    'autoconnect': true,
    'reconnection': true,
  });
  static connectSocket() async {
    socket.connect();
    socket.emit('setup', await getUid());
    socket.onConnect((_) {
      print('connect');
    });
  }

  static getNewChat() {
    print("-----------> listening new chats");
    socket.on("newChat", (chat) {
      final chatsListController = Get.find<ChatsListController>();
      chatsListController.fetchChatsList();
    });
  }

  static joinChat(String chatId, Function scroll) {
    final chatMessagesController = Get.find<ChatMessagesController>();
    chatMessagesController.messages.clear();
    socket.emit("joinChat", {"chatId": chatId});
    socket.on("allMessages", (res) {
      chatMessagesController.messages.clear();
      for (var message in res) {
        chatMessagesController.addMessages(ChatMessages.fromMap(message));
      }
      scroll();
    });
  }

  static sendMessage({
    required String uid,
    required String message,
    required String chatId,
  }) {
    socket.emit("message", {
      "senderId": uid,
      "content": message,
      "chatId": chatId,
    });
  }

  static clearListeners() {
    socket.clearListeners();
    getNewChat();
  }

  static void listenMessages(Function scroll) {
    final chatMessagesController = Get.find<ChatMessagesController>();
    socket.on('messageUpdate', (res) {
      print('---------------> $res');
      chatMessagesController.addMessages(ChatMessages.fromMap(res));
      scroll();
    });
  }
}

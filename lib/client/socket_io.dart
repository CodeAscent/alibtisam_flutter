import 'package:alibtisam_flutter/features/bottomNav/controller/chat_messages.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/chats_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/chat_message.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam_flutter/network/api_urls.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnection {
  static IO.Socket socket = IO.io(base_url, <String, dynamic>{
    'transports': ['websocket'],
    'autoconnect': true,
    'reconnection': true,
  });
  static connectSocket() {
    socket.connect();
    socket.emit('setup');
    socket.onConnect((_) {
      print('connect');
    });
  }

  static disconnectSocket() {
    socket.dispose();
  }

  static joinChat(String chatId, String uid, Function scroll) {
    final chatMessagesController = Get.find<ChatMessagesController>();

    socket.emit("joinChat", {
      "chatId": chatId,
      "userId": uid,
    });
    socket.on("fetchMessages", (res) {
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

  static void listenMessages(Function scroll) {
    final chatMessagesController = Get.find<ChatMessagesController>();
    socket.on('update', (res) {
      print('---------------> ');
      chatMessagesController.addMessages(ChatMessages.fromMap(res));
      scroll();
    });
  }

  // static void fetchChats(String uid) {
  //   final chatsListController = Get.find<ChatsListController>();
  //   socket.emit('chats', {"uid": uid});
  //   socket.on('chatsList', (res) {
  //     for (var chat in res) {
  //       chatsListController.addChatsToList(ChatsList.fromMap(chat));
  //     }
  //   });
  // }
}

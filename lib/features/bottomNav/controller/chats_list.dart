import 'package:alibtisam_flutter/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:get/get.dart';

class ChatsListController extends GetxController {
  List<ChatsList> chats = [];
  addChatsToList(ChatsList chat) {
    chats.add(chat);
    update();
  }
  fetchChatsList() async {
    final res = await ApiRequests().getChatsList();
    if (res != null) {
      chats = res;
      update();
    }
  }
}

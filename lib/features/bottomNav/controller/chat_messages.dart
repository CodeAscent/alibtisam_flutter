import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:get/get.dart';

class ChatMessagesController extends GetxController {
  List<ChatMessages> messages = [];
  RxBool meesageSending = false.obs;
  updateMessageSendingLoading(bool val) {
    meesageSending.value = val;
  }

  addMessages(ChatMessages chatMessages) {
    messages.add(chatMessages);
    update();
  }
}

import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:get/get.dart';

class ChatMessagesController extends GetxController {
  List<ChatMessages> messages = [];

  addMessages(ChatMessages chatMessages) {
    messages.add(chatMessages);
    update();
  }
}

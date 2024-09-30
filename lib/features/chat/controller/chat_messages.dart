import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class ChatMessagesController extends GetxController {
  List<ChatMessages> messages = [];
  RxBool meesageSending = false.obs;
  Map<String, String?> _thumbnails = {};

  updateMessageSendingLoading(bool val) {
    meesageSending.value = val;
  }

  addMessages(ChatMessages chatMessages) {
    messages.add(chatMessages);
    update();
  }

  // Method to generate thumbnail for a video
  Future<void> loadThumbnailFor(ChatMessages message) async {
    if (_thumbnails.containsKey(message.mediaUrl)) {
      // Thumbnail is already generated for this video
      return;
    }

    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: message.mediaUrl!,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 64,
        quality: 10,
      );

      if (thumbnailPath != null) {
        _thumbnails[message.mediaUrl!] = thumbnailPath;
        update();
      }
    } catch (e) {
      print("Error generating thumbnail: $e");
    }
  }

  Future<String?> getThumbnail(String? mediaUrl) async {
    return _thumbnails[mediaUrl];
  }
}

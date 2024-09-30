import 'dart:io';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart' as aw;

class MediaDownloader {
  // Function to download the media (image/video) from a URL
  Future<void> downloadMedia(String mediaUrl, {bool isVideo = false}) async {
    try {
      // Request storage permission (for Android)
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
      }

      // Make an HTTP GET request to fetch the media bytes
      final response = await http.get(Uri.parse(mediaUrl));

      if (response.statusCode == 200) {
        // Get the directory to save the media
        Directory directory = await getApplicationDocumentsDirectory();
        if (Platform.isAndroid) {
          directory = Directory('/storage/emulated/0/Download'); // For Android's public Downloads folder
        }
        String fileName = mediaUrl.split('/').last;

        // If it's a video, make sure it has a proper video extension
        if (isVideo && !fileName.endsWith('.mp4')) {
          fileName = '$fileName.mp4'; // Set the default extension to .mp4 if not present
        }

        String filePath = '${directory.path}/$fileName';

        // Save the media to the device's storage
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Show a success message
        customSnackbar(
            'File saved successfully: $fileName', aw.ContentType.success);

        print('File saved successfully to $filePath');
      } else {
        print('Failed to download media: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading media: $e');
    }
  }
}

import 'dart:io';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDownloader {
  // Function to download the image from a URL
  Future<void> downloadImage(String imageUrl) async {
    try {
      // Request storage permission (for Android)
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
      }

      // Make an HTTP GET request to fetch the image bytes
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get the directory to save the image
        Directory directory = await getApplicationDocumentsDirectory();
        if (Platform.isAndroid) {
          directory = Directory(
              '/storage/emulated/0/Download'); // For Android's public Downloads folder
        }
        String fileName = imageUrl.split('/').last;
        String filePath = '${directory.path}/$fileName';

        // Save the image to the device's storage
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        customSnackbar('File saved successfully', ContentType.success);
        print('File saved successfully to $filePath');
      } else {
        print('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}

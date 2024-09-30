import 'dart:convert';
import 'dart:io';

import 'package:alibtisam/client/socket_io.dart';
import 'package:alibtisam/core/services/image_download.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  final File? imageFile;
  final bool sending;
  final String? groupId;
  final String? imageUrl;
  const ImagePreview(
      {super.key,
      this.imageFile,
      required this.sending,
      this.groupId,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'.tr),
      ),
      body: Container(
        child: Center(
          child: sending
              ? Image.file(
                  File(imageFile!.path),
                  height: 500,
                  width: Get.width,
                  //   fit: BoxFit.cover,
                )
              : Image.network(
                  imageUrl!,
                  height: 500,
                  width: Get.width,
                  //   fit: BoxFit.cover,
                ),
        ),
      ),
      floatingActionButton: Visibility(
          visible: sending,
          replacement: FloatingActionButton(
            onPressed: () async {
              ImageDownloader().downloadImage(imageUrl!);
            },
            child: Icon(CupertinoIcons.cloud_download),
          ),
          child: FloatingActionButton(
            onPressed: () async {
              final bytes = await imageFile?.readAsBytes();

              final base64Image = base64Encode(bytes!);
              SocketConnection.sendMessage(
                uid: userController.user!.id!,
                message: '',
                groupId: groupId!,
                file: base64Image,
                type: 'image',
              );
              Get.back();
            },
            child: Icon(CupertinoIcons.share),
          )),
    );
  }
}

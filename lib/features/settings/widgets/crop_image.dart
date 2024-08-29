import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCropImage extends StatelessWidget {
  CustomCropImage({super.key, required this.imageData});
  final Uint8List imageData;
  final _controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar:
            SizedBox(height: 70, child: CustomContainerButton(label: 'Update')),
        body: Crop(
            aspectRatio: 10 / 10,
            image: imageData,
            controller: _controller,
            onCropped: (image) {
              // do something with cropped image data
            }));
  }
}

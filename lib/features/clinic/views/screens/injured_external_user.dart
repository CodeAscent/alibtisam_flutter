import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/clinic/viewmodel/clinic_appointment_viewmodel.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class InjuredExternalUserForm extends StatefulWidget {
  const InjuredExternalUserForm({super.key});

  @override
  State<InjuredExternalUserForm> createState() =>
      _InjuredExternalUserFormState();
}

class _InjuredExternalUserFormState extends State<InjuredExternalUserForm> {
  final userController = Get.find<UserController>();

  double injuryValue = 0;
  BodyParts _bodyParts = const BodyParts();
  GlobalKey _boundaryKey = GlobalKey();
  final _description = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final clinicAppointmentViewmodel = Get.find<ClinicAppointmentViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Injury Details'),
        ),
        body: Obx(
          () => clinicAppointmentViewmodel.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _description,
                        label: 'Injury Description',
                        maxLines: 3,
                      ),
                      Divider(),
                      Text(
                        'Select Injured Areas',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(
                        height: 500,
                        child: RepaintBoundary(
                          key: _boundaryKey,
                          child: BodyPartSelectorTurnable(
                            bodyParts: _bodyParts,
                            selectedColor: Colors.red.shade400,
                            unselectedColor: Colors.green.shade200,
                            unselectedOutlineColor: Colors.white,
                            selectedOutlineColor: Colors.white,
                            onSelectionUpdated: (p) {
                              setState(() {
                                _bodyParts = p;
                              });
                            },
                            labelData: const RotationStageLabelData(
                              front: 'Front',
                              left: 'Left',
                              right: 'Right',
                              back: 'Back',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Spacer(),
                      CustomContainerButton(
                        label: 'Submit',
                        onTap: () async {
                          await _captureAndSendImage();
                          if (_formState.currentState!.validate()) {
                            await clinicAppointmentViewmodel
                                .addClinicAppointment(
                                  userAppointmentType: "EXTERNAL",
                                    userId: userController.user!.id.toString(),
                                    injuryDescription: _description.text,
                                    injuryBodyImage: imageFile!);
                          }
                        },
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  File? imageFile;
  Future<void> _captureAndSendImage() async {
    try {
      RenderRepaintBoundary boundary = _boundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      File imgFile = File(
          '${directory.path}/injured_player_image${DateTime.now().millisecondsSinceEpoch}.png');
      await imgFile.writeAsBytes(pngBytes);
      imageFile = imgFile;
      setState(() {});
    } catch (e) {
      Logger().e("Error capturing and sending image: $e");
    }
  }
}

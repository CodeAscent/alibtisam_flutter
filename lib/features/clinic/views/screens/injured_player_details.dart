import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/features/clinic/models/injured_player_model.dart';
import 'package:alibtisam/features/clinic/viewmodel/clinic_appointment_viewmodel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';

class InjuredPlayerDetailsForm extends StatefulWidget {
  final InjuredPlayerModel playerData;
  const InjuredPlayerDetailsForm({super.key, required this.playerData});

  @override
  State<InjuredPlayerDetailsForm> createState() =>
      _InjuredPlayerDetailsFormState();
}

class _InjuredPlayerDetailsFormState extends State<InjuredPlayerDetailsForm> {
  Map injuryCondition = {
    1: {
      "condition": "Mild",
      "color": Color(0xFF4CAF50), // Green
    },
    2: {
      "condition": "Moderate",
      "color": Color(0xFFFFEB3B), // Yellow
    },
    3: {
      "condition": "Moderate to Severe",
      "color": Color(0xFFFF9800), // Orange
    },
    4: {
      "condition": "Severe",
      "color": Color(0xFFF44336), // Red
    },
    5: {
      "condition": "Critical",
      "color": Color(0xFFB71C1C), // Dark Red
    },
  };
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
              : SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playerData.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      Text('Player Id : ${widget.playerData.pId}'),
                      Text(
                          'Injury Level: ${widget.playerData.readiness!.injury}'),
                      Row(
                        children: [
                          Text('Injury Condition: '),
                          Text(
                              '${injuryCondition[widget.playerData.readiness!.injury]['condition']}',
                              style: TextStyle(
                                  color: injuryCondition[widget
                                      .playerData.readiness!.injury]['color'],
                                  fontWeight: FontWeight.w800))
                        ],
                      ),
                      Divider(),
                      Text(
                        'Readiness',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      Text("hydration: 2"),
                      Text("stress: 4"),
                      Text("sleep: 3"),
                      Text("overall: 2"),
                      Text("nutrition: 2"),
                      Divider(),
                      CustomTextField(
                        controller: _description,
                        label: 'Injury Description',
                        maxLines: 4,
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
                      CustomContainerButton(
                        label: 'Submit',
                        onTap: () async {
                          await _captureAndSendImage();
                          if (_formState.currentState!.validate()) {
                            await clinicAppointmentViewmodel
                                .addClinicAppointment(
                                    userId: widget.playerData.userId.toString(),
                                    injuryDescription: _description.text,
                                    injuryBodyImage: imageFile!,
                                    userAppointmentType: 'INTERNAL');
                          }
                        },
                      )
                    ],
                  ),
                )),
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

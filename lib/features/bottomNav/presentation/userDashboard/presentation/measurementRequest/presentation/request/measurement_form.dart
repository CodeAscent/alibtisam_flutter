import 'package:alibtisam_flutter/helper/common/widgets/custom_container_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementForm extends StatefulWidget {
  const MeasurementForm({super.key});

  @override
  State<MeasurementForm> createState() => _MeasurementRequestState();
}

class _MeasurementRequestState extends State<MeasurementForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomTextField(width: Get.width * 0.46, label: "height feet"),
                SizedBox(
                  width: 10,
                ),
                CustomTextField(width: Get.width * 0.46, label: "weight kg")
              ],
            ),
            Row(
              children: [
                CustomTextField(width: Get.width * 0.46, label: "chest size"),
                SizedBox(
                  width: 10,
                ),
                CustomTextField(
                    width: Get.width * 0.46, label: "normall chest size")
              ],
            ),
            Row(
              children: [
                CustomTextField(width: Get.width * 0.46, label: "high jump"),
                SizedBox(
                  width: 10,
                ),
                CustomTextField(width: Get.width * 0.46, label: "low jump")
              ],
            ),
            Row(
              children: [
                CustomTextField(
                    width: Get.width * 0.46, label: "heartBeatingRate"),
                SizedBox(
                  width: 10,
                ),
                CustomTextField(width: Get.width * 0.46, label: "pulseRate")
              ],
            ),
            Row(
              children: [
                CustomTextField(width: Get.width * 0.46, label: "tShirtSize"),
                SizedBox(
                  width: 10,
                ),
                CustomTextField(width: Get.width * 0.46, label: "waistSize")
              ],
            ),
            Row(
              children: [
                CustomTextField(width: Get.width * 0.46, label: "shoeSize"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Spacer(),
            CustomContainerButton(label: "submit".tr),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

import 'package:SNP/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementPlayerData extends StatelessWidget {
  const MeasurementPlayerData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kAppGreyColor()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            kReapetedContainer(
                width: Get.width, label: "fullName".tr, title: "ABCD"),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46, label: "gender".tr, title: "Male"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "dateOfBirth".tr,
                    title: "12/07/2002"),
              ],
            ),
            kReapetedContainer(
                width: Get.width, label: "fatherName".tr, title: "ABCD"),
            kReapetedContainer(
                width: Get.width, label: "motherName".tr, title: "ABCD"),
            kReapetedContainer(
                width: Get.width, label: "email".tr, title: "abcd@gmail.com"),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46, label: "height".tr, title: "5.8"),
                kReapetedContainer(
                    width: Get.width * 0.46, label: "weight".tr, title: "56"),
              ],
            ),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "bloodGroup".tr,
                    title: "A+"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "contact".tr,
                    title: "9630852741"),
              ],
            ),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46, label: "city".tr, title: "Bhopal"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "postalCode".tr,
                    title: "462001"),
              ],
            ),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46, label: "state".tr, title: "MP"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "country".tr,
                    title: "India"),
              ],
            ),
            kReapetedContainer(
                width: Get.width,
                label: "address".tr,
                title: "H.No 100 MP Nagar Bhopal"),
            kReapetedContainer(
                width: Get.width,
                label: "correspondanceAddress".tr,
                title: "Bhopal"),
            kReapetedContainer(
                width: Get.width,
                label: "relatipWithApplicant".tr,
                title: "Self"),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "chestSize".tr,
                    title: "38"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "normallChestSize".tr,
                    title: "36"),
              ],
            ),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46, label: "highJump".tr, title: "9"),
                kReapetedContainer(
                    width: Get.width * 0.46, label: "lowJump".tr, title: "6"),
              ],
            ),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "heartBeatingRate".tr,
                    title: "95"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "pulseRate".tr,
                    title: "90"),
              ],
            ),
            Row(
              children: [
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "tshirtSize".tr,
                    title: "M"),
                kReapetedContainer(
                    width: Get.width * 0.46,
                    label: "waistSize".tr,
                    title: "36"),
              ],
            ),
            kReapetedContainer(
                width: Get.width * 0.46, label: "shoeSize".tr, title: "8"),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Container kReapetedContainer(
      {required double width, required String label, required String title}) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      padding: EdgeInsets.only(left: 10),
      height: 50,
      width: width,
      decoration: BoxDecoration(
          color: kAppGreyColor(), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

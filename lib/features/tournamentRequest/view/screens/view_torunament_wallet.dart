import 'dart:io';

import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/tournamentRequest/models/tournament_model.dart';
import 'package:alibtisam/features/tournamentRequest/viewmodel/tournament_request_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class ViewTorunamentWallet extends StatefulWidget {
  final TournamentModel tournament;
  const ViewTorunamentWallet({super.key, required this.tournament});

  @override
  State<ViewTorunamentWallet> createState() => _ViewTorunamentWalletState();
}

class _ViewTorunamentWalletState extends State<ViewTorunamentWallet> {
  XFile? invoiceImage;
  final globalKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  final amount = TextEditingController();
  final tournamentRequestViewmodel = Get.find<TournamentRequestViewmodel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentRequestViewmodel>(initState: (state) {
      tournamentRequestViewmodel.viewTournamentRequests(
          id: widget.tournament.id!);
    }, builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Visibility(
              visible:
                  controller.tournament!.status == 'ACCOUNT-MANAGER-REVIEWED',
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return Container(
                            child: Material(
                              color: Colors.transparent,
                              child: Form(
                                key: globalKey,
                                child: AlertDialog(
                                  title: Text('Add Invoice'),
                                  content: Container(
                                    height: 380,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {},
                                          child: Container(
                                            height: 140,
                                            width: 140,
                                            decoration: BoxDecoration(
                                                color: kAppGreyColor(),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: invoiceImage != null
                                                      ? Image.file(
                                                          File(invoiceImage!
                                                              .path),
                                                          fit: BoxFit.cover,
                                                          height: 140,
                                                          width: 140,
                                                        )
                                                      : Text('Pick Image'),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: invoiceImage == null
                                                      ? ImagePickerWidget(
                                                          diameter: 25,
                                                          shape: ImagePickerWidgetShape
                                                              .circle, // ImagePickerWidgetShape.square
                                                          isEditable: true,
                                                          onChange:
                                                              (File file) {
                                                            setState(() {
                                                              invoiceImage =
                                                                  XFile(file
                                                                      .path);
                                                            });
                                                          },
                                                        )
                                                      : CircleAvatar(
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(
                                                                  () {
                                                                    invoiceImage =
                                                                        null;
                                                                  },
                                                                );
                                                              },
                                                              icon: Icon(Icons
                                                                  .delete)),
                                                        ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        CustomTextField(
                                          label: 'Title'.tr,
                                          controller: title,
                                        ),
                                        CustomTextField(
                                          label: 'Description'.tr,
                                          controller: description,
                                        ),
                                        CustomTextField(
                                          label: 'Amount'.tr,
                                          controller: amount,
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                          invoiceImage = null;
                                          title.clear();
                                          amount.clear();
                                          description.clear();
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () async {
                                          if (invoiceImage == null) {
                                            customSnackbar(
                                                'Pick an Invoice Image',
                                                ContentType.failure);
                                          } else if (globalKey.currentState!
                                              .validate()) {
                                            await tournamentRequestViewmodel
                                                .addReceipt(
                                                    id: widget.tournament
                                                        .tournamentId!.id!,
                                                    title: title.text,
                                                    amount: amount.text,
                                                    description:
                                                        description.text,
                                                    invoiceImage:
                                                        invoiceImage!);
                                            await tournamentRequestViewmodel
                                                .viewTournamentRequests(
                                                    id: widget.tournament.id!);
                                            Get.back();
                                          } else {
                                            customSnackbar(
                                                'Please fill in all required fields',
                                                ContentType.failure);
                                          }
                                        },
                                        child: Text('Confirm'))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Text('Add Receipt'),
              ),
            )
          ],
        ),
        body: controller.loading.value
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
                        'Approved Amount: ' +
                            controller.tournament!.tournamentId!.approvedAmount
                                .toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Remaining Amount: ' +
                            controller.tournament!.tournamentId!.remainingAmount
                                .toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Exceeded Amount: ' +
                            controller.tournament!.tournamentId!.exceededAmount
                                .toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller
                            .tournament!.tournamentId!.receipts.length,
                        itemBuilder: (context, index) {
                          final receipt = controller
                              .tournament!.tournamentId!.receipts[index];
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Image.network(
                                  receipt['invoice'],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  receipt['title'].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  receipt['description'].toString(),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: 'status'.tr + ' ',
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text: receipt['status'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: receipt['status'] ==
                                                      'APPROVED'
                                                  ? Colors.green
                                                  : Colors.orange))
                                    ])),
                                Text(
                                  'Amount: ' + receipt['amount'].toString(),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

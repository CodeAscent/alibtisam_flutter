import 'dart:convert';

import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/features/bottomNav/controller/measurement_req.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/enrollment/views/pages/view_addmision_form.dart';
import 'package:alibtisam/features/playerRequests/presentation/request/measurement_from.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerRequests extends StatefulWidget {
  const PlayerRequests({super.key});

  @override
  State<PlayerRequests> createState() => _PlayerRequestsState();
}

class _PlayerRequestsState extends State<PlayerRequests> {
  final measurementReqController = Get.find<MeasurementReqController>();
  @override
  void initState() {
    super.initState();
    measurementReqController.fetchMeasurementRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GetBuilder(
        builder: (MeasurementReqController controller) {
          return measurementReqController.measurementRequests == null ||
                  measurementReqController.measurementRequests.length == 0
              ? CustomEmptyWidget()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.measurementRequests!.length,
                          itemBuilder: (context, index) {
                            UserModel user = UserModel.fromMap(controller
                                .measurementRequests![index]['playerId']);

                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ViewPlayerByUserModel(
                                      player: user,
                                      updatePlayer: true,
                                      measurementId: controller
                                          .measurementRequests![index]['_id'],
                                    ));
                              },
                              child: kCustomListTile(
                                key: user.name!.capitalize!,
                                value: user.email!,
                              ),
                            );
                          })
                    ],
                  ),
                );
        },
      )),
    );
  }
}

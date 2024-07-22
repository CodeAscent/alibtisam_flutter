import 'dart:convert';

import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/features/bottomNav/controller/measurement_req.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/playerRequests/presentation/request/measurement_from.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PlayerRequests extends StatelessWidget {
  const PlayerRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final measurementReqController = Get.find<MeasurementReqController>();
    measurementReqController.fetchMeasurementRequests();
    return Scaffold(
      body: CustomLoader(
        child: SafeArea(child: GetBuilder(
          builder: (MeasurementReqController controller) {
            return measurementReqController.measurementRequests.length == 0
                ? CustomEmptyWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.measurementRequests.length,
                            itemBuilder: (context, index) {
                              UserModel user = UserModel.fromMap(controller
                                  .measurementRequests[index]['playerId']);

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ViewPlayerByUserModel(
                                        player: user,
                                        updatePlayer: true,
                                        measurementId: controller
                                            .measurementRequests[index]['_id'],
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
      ),
    );
  }
}

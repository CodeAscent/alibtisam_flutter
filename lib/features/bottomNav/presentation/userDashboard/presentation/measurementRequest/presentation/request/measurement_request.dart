import 'package:SNP/features/bottomNav/controller/measurement_req.dart';
import 'package:SNP/features/bottomNav/model/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/request/measurement_form.dart';
import 'package:SNP/core/common/widgets/custom_empty_icon.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/theme/app_colors.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementRequest extends StatelessWidget {
  const MeasurementRequest({super.key});

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
                : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.measurementRequests.length,
                        itemBuilder: (context, index) {
                          UserModel user = UserModel.fromMap(controller
                              .measurementRequests[index]['playerId']);
                          return Container(
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: kAppGreyColor(),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              onTap: () {
                                Get.to(() {
                                  return MeasurementForm(
                                    user: user,
                                    requestId: controller
                                        .measurementRequests[index]['_id'],
                                  );
                                })!
                                    .then((e) => measurementReqController
                                        .fetchMeasurementRequests());
                                ;
                              },
                              title: Text(user.name.capitalize!),
                              subtitle: Text(user.email),
                              trailing: IconButton(
                                  onPressed: () {
                                    Get.to(() =>
                                        ViewPlayerByUserModel(player: user));
                                  },
                                  icon: Icon(CupertinoIcons.info)),
                            ),
                          );
                        },
                      ),
                    ],
                  );
          },
        )),
      ),
    );
  }
}

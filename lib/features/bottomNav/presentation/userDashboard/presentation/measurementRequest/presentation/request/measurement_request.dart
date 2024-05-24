import 'package:alibtisam_flutter/features/bottomNav/controller/measurement_req.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/request/measurement_form.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementRequest extends StatelessWidget {
  const MeasurementRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final measurementReqController = Get.find<MeasurementReqController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: GetBuilder(
          initState: (state) {
            measurementReqController.fetchMeasurementRequests();
          },
          init: MeasurementReqController(),
          builder: (controller) {
            return 
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.measurementRequests.length,
                  itemBuilder: (context, index) {
                    UserModel user = UserModel.fromMap(
                        controller.measurementRequests[index]['playerId']);
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
                              requestId: controller.measurementRequests[index]
                                  ['_id'],
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
                              Get.to(() => ViewAddmisionForm(player: user));
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

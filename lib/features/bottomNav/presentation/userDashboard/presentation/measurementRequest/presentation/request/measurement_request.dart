import 'package:alibtisam_flutter/features/bottomNav/controller/measurement_req.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/request/measurement_form.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementRequest extends StatefulWidget {
  const MeasurementRequest({super.key});

  @override
  State<MeasurementRequest> createState() => _MeasurementRequestState();
}

class _MeasurementRequestState extends State<MeasurementRequest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final measurementReqController = Get.find<MeasurementReqController>();
    return Scaffold(
      body: measurementReqController.measurementRequests.length == 0
          ? CustomEmptyWidget()
          : CustomLoader(
              child: SingleChildScrollView(
                child: SafeArea(
                    child: GetBuilder(
                  initState: (state) {
                    measurementReqController.fetchMeasurementRequests();
                  },
                  init: MeasurementReqController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
            ),
    );
  }
}

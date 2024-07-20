import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementHistory extends StatelessWidget {
  const MeasurementHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiRequests().getMesurementHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length == 0
                ? CustomEmptyWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            UserModel user = UserModel.fromMap(
                                snapshot.data[index]['playerId']);
                            return Container(
                              margin: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: kAppGreyColor(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() =>
                                      ViewPlayerByUserModel(player: user));
                                },
                                title: Text(user.name!.capitalize!),
                                subtitle: Text(user.email!),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
          }
          return Center();
        },
      ),
    );
  }
}

import 'package:alibtisam_flutter/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/external/external_enrollment_form.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_container_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuardianAllForms extends StatefulWidget {
  const GuardianAllForms({super.key});

  @override
  State<GuardianAllForms> createState() => _GuardianAllFormsState();
}

class _GuardianAllFormsState extends State<GuardianAllForms> {
  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      shouldAddCallback: true,
      onWillPop: () async {
        Get.to(() => BottomNav());
        return true;
      },
      child: CustomLoader(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.to(() => BottomNav());
                },
                icon: Icon(
                  Icons.navigate_before,
                  size: 38,
                )),
            title: Text("addmisionForm".tr),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FutureBuilder<List<UserModel>>(
                    future: ApiRequests().getUsersByGuardian(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length - 1,
                          itemBuilder: (context, index) {
                            UserModel player = snapshot.data![index + 1];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ViewAddmisionForm(
                                      player: player,
                                    ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: kAppGreyColor(),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              player.pic,
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(player.name, maxLines: 1),
                                                Text(player.email, maxLines: 1),
                                                SizedBox(height: 5),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  decoration: BoxDecoration(
                                                      color: player.requests[
                                                                  'status'] ==
                                                              'PENDING'
                                                          ? Colors.orange
                                                          : player.requests[
                                                                      'status'] ==
                                                                  'COMPLETED'
                                                              ? Colors.blue
                                                              : Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    player.requests['status'],
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
              child: CustomContainerButton(
                  onTap: () {
                    Get.to(() => ExternalEnrollmentForm());
                  },
                  label: 'New Form')),
        ),
      ),
    );
  }
}

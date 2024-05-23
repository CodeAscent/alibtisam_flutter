import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam_flutter/features/dummySplash/dummy_splash.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchUser extends StatefulWidget {
  const SwitchUser({super.key});

  @override
  State<SwitchUser> createState() => _SwitchUserState();
}

class _SwitchUserState extends State<SwitchUser> {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Switch User"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<UserModel>>(
              future: ApiRequests().getUsersByGuardian(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 40,
                      children: [
                        ...List.generate(snapshot.data!.length, (int index) {
                          final player = snapshot.data![index];
                          return GestureDetector(
                            onTap: () async {
                              if (userController.user.id == player.id) {
                                Get.back();
                              } else {
                                print(player.id);
                                await ApiRequests().getTokenById(player.id);
                                Get.offAll(() => DummySplash());
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Container(
                                height: 150,
                                child: Column(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      player.pic,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(player.name, maxLines: 1),
                                ]),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  );
                } else {
                  return Center();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

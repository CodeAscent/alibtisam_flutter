import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:alibtisam/network/http_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolarizePlayer extends StatelessWidget {
  final UserModel player;
  const PolarizePlayer({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name!.capitalize!),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomContainerButton(
          onTap: () {
            Get.defaultDialog(
                titleStyle: TextStyle(fontSize: 12),
                title: "Are you sure you want update \n${player.name}'s stage?",
                content: Column(
                  children: [
                    Text('Update Stage From  '),
                    Text(
                      '${player.stage} --> ${player.stage == 'ACADEMY' ? 'SCHOOL' : 'PROFESSIONAL'}',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ],
                ),
                confirm: TextButton(
                    onPressed: () {
                      ApiRequests().updatePlayerStage(
                          playerId: player.id!,
                          stage: player.stage == 'ACADEMY'
                              ? 'SCHOOL'
                              : 'PROFESSIONAL');
                      Get.back();
                    },
                    child: Text('Confirm')));
          },
          flexibleHeight: 60,
          label: 'Update Stage',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    height: 200,
                    width: 200,
                    child: HttpWrapper.networkImageRequest(player.pic!)),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Get.to(() => ViewPlayerByUserModel(player: player));
                        },
                        child: Text('VIEW DETAILS')))
              ],
            ),
            SizedBox(height: 20),
            kCustomListTile(() {}, 'Current Game', player.name!),
            kCustomListTile(() {}, 'Current Stage', player.stage!)
          ],
        ),
      ),
    );
  }

  GestureDetector kCustomListTile(
      void Function()? onTap, String key, String val) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kAppGreyColor())),
        child: ListTile(
          title: Text(key),
          subtitle: Text(val.toString()),
        ),
      ),
    );
  }
}

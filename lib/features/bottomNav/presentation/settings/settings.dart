import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/presentation/switch_user.dart';
import 'package:alibtisam_flutter/helper/common/constants/switch_theme_dialog.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/presentation/profile.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/widgets/custom_settings_card.dart';
import 'package:alibtisam_flutter/helper/common/constants/logout_user.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    ApiRequests().getUser();
  }

  final userController = Get.find<UserController>()..user;
  @override
  Widget build(BuildContext context) {
    final user = userController.user;
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(160),
                          child: Image.network(
                            user.pic,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(user.userName.capitalize!),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                        onTap: () {
                          LoadingManager.dummyLoading();
                          Get.to(() => ProfileScreen(
                                user: user,
                              ));
                        },
                        child: CustomSettingsCard(label: "Profile")),
                    Visibility(
                      visible: user.role == "GUARDIAN" || user.guardianId != '',
                      child: GestureDetector(
                          onTap: () {
                            Get.to(() => SwitchUser());
                          },
                          child: CustomSettingsCard(label: "Switch User")),
                    ),
                    GestureDetector(
                        onTap: () {
                          kSwitchThemeDialog(context);
                        },
                        child: CustomSettingsCard(label: "Theme")),
                    CustomSettingsCard(label: "Language"),
                    CustomSettingsCard(label: "About"),
                  ],
                ),
                SizedBox(height: 80),
                GestureDetector(
                  onTap: () {
                    kLogoutUser(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade500),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.logout, color: Colors.red.shade500),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

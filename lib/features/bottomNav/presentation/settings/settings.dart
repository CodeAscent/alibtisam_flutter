import 'package:SNP/Localization/switch.dart';
import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/presentation/settings/presentation/about.dart';
import 'package:SNP/features/bottomNav/presentation/settings/presentation/help_support.dart';
import 'package:SNP/features/bottomNav/presentation/settings/presentation/switch_user.dart';
import 'package:SNP/features/bottomNav/presentation/settings/widgets/coach_profile.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:SNP/core/common/constants/switch_theme_dialog.dart';
import 'package:SNP/features/bottomNav/presentation/settings/presentation/profile/profile.dart';
import 'package:SNP/features/bottomNav/presentation/settings/widgets/custom_settings_card.dart';
import 'package:SNP/core/common/constants/logout_user.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    userController.fetchUser();
  }

  final userController = Get.find<UserController>()..user;
  @override
  Widget build(BuildContext context) {
    final user = userController.user;

    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                kLogoutUser(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "logOut".tr,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade500),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.logout, color: Colors.red.shade500),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (user != null)
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
                            if (user.role == 'EXTERNAL USER' ||
                                user.role == 'GUARDIAN') {
                              Get.to(() => ProfileScreen(
                                    user: user,
                                  ));
                            } else if (user.role == 'INTERNAL USER') {
                              Get.to(() => ViewPlayerByUserModel(player: user));
                            } else {
                              Get.to(() => CoachProfile(user: user));
                            }
                          },
                          child: CustomSettingsCard(label: "profile".tr)),
                      Visibility(
                        visible:
                            user.role == "GUARDIAN" || user.guardianId != '',
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
                          child: CustomSettingsCard(label: "theme".tr)),
                      GestureDetector(
                          onTap: () {
                            showLanguageSwitchDialog(context);
                          },
                          child: CustomSettingsCard(label: "language".tr)),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => HelpSupportPage());
                          },
                          child: CustomSettingsCard(label: "help&support".tr)),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => AboutOrganization());
                          },
                          child: CustomSettingsCard(label: "about".tr)),
                    ],
                  ),
                SizedBox(height: 150),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

import 'package:alibtisam_flutter/helper/common/constants/confirm_exit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alibtisam_flutter/features/commons/home/presentation/userDashboard/user_dashboard.dart';
import 'package:alibtisam_flutter/features/commons/home/presentation/settings/settings.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:get/get.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  List<Widget> pages = [UserDashboard(), SettingScreen()];

  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  bool isHomeSelected = true;
  bool isSettingsSelected = false;

  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      shouldAddCallback: true,
      onWillPop: () async {
        kConfirmExit(context);
        return false;
      },
      child: Scaffold(
          body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: 2,
            onPageChanged: (value) => setState(() {
              if (value == 0) {
                setState(() {
                  isHomeSelected = true;
                  isSettingsSelected = false;
                  currentIndex = 0;
                });
              } else {
                setState(() {
                  isSettingsSelected = true;
                  isHomeSelected = false;
                  currentIndex = 1;
                });
              }
            }),
            itemBuilder: (context, index) => pages[index],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: kAppGreyColor(),
                    borderRadius: BorderRadius.circular(160),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHomeSelected = true;
                            isSettingsSelected = false;
                            currentIndex = 0;
                          });
                          pageController.animateToPage(currentIndex,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        },
                        child: kRepeatedBottomNavItem(
                            "Home", CupertinoIcons.home, isHomeSelected),
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isSettingsSelected = true;
                              isHomeSelected = false;
                              currentIndex = 1;
                            });
                            pageController.animateToPage(currentIndex,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                          child: kRepeatedBottomNavItem("Settings",
                              CupertinoIcons.settings, isSettingsSelected)),
                    ],
                  ),
                ),
              )),
        ],
      )),
    );
  }

  Widget kRepeatedBottomNavItem(String label, IconData icon, bool isSelected) {
    return SizedBox(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !isSelected
              ? Icon(
                  icon,
                  color: !isSelected ? null : primaryColor(),
                )
              : Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: primaryColor()),
                ),
          SizedBox(height: 5),
          !isSelected
              ? SizedBox()
              : Container(
                  height: 5,
                  width: 40,
                  color: primaryColor(),
                )
        ],
      ),
    );
  }
}

import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/sports/models/club_sport.dart';
import 'package:alibtisam/features/sports/viewmodel/sports_viewmodel.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableSports extends StatefulWidget {
  const AvailableSports({super.key});

  @override
  State<AvailableSports> createState() => _AvailableSportsState();
}

class _AvailableSportsState extends State<AvailableSports> {
  final sportsViewmodel = Get.find<SportsViewmodel>();
  final options = LiveOptions(
    delay: Duration(milliseconds: 200),
    showItemInterval: Duration(milliseconds: 200),
    showItemDuration: Duration(milliseconds: 900),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SportsViewmodel>(initState: (state) {
      sportsViewmodel.getClubSports();
    }, builder: (controller) {
      return Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text('sports'.tr),
          ),
          body: controller.isLoading.value
              ? CustomLoader()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      LiveList.options(
                        itemCount: controller.clubSports.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: buildAnimatedItem,
                        options: options,
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }

  // Build animated item (helper for all examples)
  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    ClubSport clubSport = sportsViewmodel.clubSports[index];

    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.5),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kAppGreyColor())),
                child: Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: ClipRRect(
                        child: HttpWrapper.networkImageRequest(clubSport.icon!),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          Get.locale.toString() == 'en_US' ||
                                  Get.locale.toString() == 'en'
                              ? clubSport.name!
                              : clubSport.arabicName!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text('Stages'.tr),
                        Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            ...List.generate(clubSport.stage!.length, (int i) {
                              List stages = clubSport.stage!;
                              stages.sort();
                              return Chip(
                                label: Text(stages[i]),
                              );
                            })
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Professional Stage'.tr),
                                content: Container(
                                  height: 180,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...List.generate(
                                            clubSport.ageCategoryIds!.length,
                                            (int i) {
                                          AgeCategory ageCategory =
                                              clubSport.ageCategoryIds![i];
                                          return Text(
                                              ageCategory.name!.capitalize!);
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.info_circle_fill,
                        color: Colors.blue,
                      )))
            ],
          )),
    );
  }
}

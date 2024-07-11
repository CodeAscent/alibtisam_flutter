import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/player_statistics.dart';
import 'package:alibtisam/features/bottomNav/viewModel/age_category_view_model.dart';
import 'package:alibtisam/features/bottomNav/viewModel/players_by_age_and_stage_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachAgeCategories extends StatefulWidget {
  const CoachAgeCategories({super.key});

  @override
  State<CoachAgeCategories> createState() => _CoachAgeCategoriesState();
}

class _CoachAgeCategoriesState extends State<CoachAgeCategories> {
  CarouselController controller = CarouselController();
  int currentIndex = 0;
  bool schoolVal = true;
  bool academyVal = false;
  String currentAgeCategory = '';
  List<AgeCategoryModel>? ageCategories;

  @override
  void initState() {
    super.initState();
    _fetchAgeCategories();
    if (userController.user!.stage != 'SCHOOL-AND-ACADEMY') {
      attendanceController.currentStage = userController.user!.stage;
    } else {
      attendanceController.currentStage = 'SCHOOL';
    }
  }

  final userController = Get.find<UserController>();
  final attendanceController = Get.find<AttendanceController>();
  Future<void> _fetchAgeCategories() async {
    List<AgeCategoryModel> fetchedCategories =
        await AgeCategoryViewModel().fetchAgeCategory();
    setState(() {
      ageCategories = fetchedCategories;
      currentAgeCategory = fetchedCategories[currentIndex].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 170,
              title: ageCategories != null
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: kGradientColor()),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CarouselSlider.builder(
                                    carouselController: controller,
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        LoadingManager.startLoading();

                                        setState(() {
                                          currentIndex = index;
                                          currentAgeCategory =
                                              ageCategories![index].id;
                                        });
                                      },
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      height: 50,
                                      autoPlay: false,
                                      enableInfiniteScroll: false,
                                    ),
                                    itemCount: ageCategories!.length,
                                    itemBuilder: (BuildContext context,
                                        int index, int realIndex) {
                                      print(ageCategories![index].id);
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              ageCategories![index]
                                                  .name
                                                  .capitalize!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ...List.generate(
                                        ageCategories!.length,
                                        (int dotIndex) => InkWell(
                                          onTap: () {
                                            controller.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.linear);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            height: currentIndex == dotIndex
                                                ? 8
                                                : 4,
                                            width: currentIndex == dotIndex
                                                ? 8
                                                : 4,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 30,
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.navigate_before,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                        if (userController.user!.stage == 'SCHOOL-AND-ACADEMY')
                          Row(
                            children: [
                              CupertinoCheckbox(
                                  value: schoolVal,
                                  onChanged: (val) {
                                    setState(() {
                                      academyVal = false;
                                      schoolVal = true;
                                      attendanceController.currentStage =
                                          'SCHOOL';
                                      LoadingManager.startLoading();
                                    });
                                  }),
                              Text('School'),
                              SizedBox(width: 20),
                              CupertinoCheckbox(
                                  value: academyVal,
                                  onChanged: (val) {
                                    setState(() {
                                      academyVal = !false;
                                      schoolVal = !true;
                                      attendanceController.currentStage =
                                          'ACADEMY';
                                      LoadingManager.startLoading();
                                    });
                                  }),
                              Text('Academy'),
                            ],
                          ),
                      ],
                    )
                  : SizedBox(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ageCategories != null
                  ? FutureBuilder<List<UserModel>>(
                      future: PlayersByAgeAndStageViewmodel()
                          .fetchPlayersByAgeAndStage(
                              stage: attendanceController.currentStage,
                              ageCategoryId: currentAgeCategory),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              UserModel user = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      PlayerStatistics(playerId: user.id));
                                },
                                child: Card(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          user.pic,
                                          height: 120,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(user.name),
                                            SizedBox(height: 10),
                                            Text('Player Id: ${user.pId}'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Icon(
                                          Icons.navigate_next,
                                          size: 35,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return SizedBox();
                      },
                    )
                  : Center(),
            )));
  }
}

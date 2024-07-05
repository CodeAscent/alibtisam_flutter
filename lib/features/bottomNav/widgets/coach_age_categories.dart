import 'package:SNP/core/theme/app_colors.dart';
import 'package:SNP/features/bottomNav/widgets/player_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        title: Stack(
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
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      height: 50,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                    ),
                    itemCount: 5,
                    disableGesture: false,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Age Category 16 -18',
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
                        5,
                        (int dotIndex) => InkWell(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: currentIndex == dotIndex ? 8 : 4,
                            width: currentIndex == dotIndex ? 8 : 4,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/launcher_icon.png',
                      height: 120,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('KJkncdcjndkjc dckjd '),
                        SizedBox(height: 10),
                        Text('Player Id: 88686885'),
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
            )
          ],
        ),
      ),
    );
  }
}

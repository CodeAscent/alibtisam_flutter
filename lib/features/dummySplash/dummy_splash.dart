import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/feed_player.dart';
import 'package:alibtisam/features/auth/view/widgets/check_login.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/presentation/event_desciption.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_manager.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_player.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DummySplash extends StatefulWidget {
  const DummySplash({super.key});

  @override
  State<DummySplash> createState() => _DummySplashState();
}

class _DummySplashState extends State<DummySplash> {
  @override
  void initState() {
    super.initState();
    removeSplash();
    flickMultiManager = FlickMultiManager();
  }

  removeSplash() async {
    await Future.delayed(Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  late FlickMultiManager flickMultiManager;

  final activePlayerController = Get.find<ActivePlayerController>();
  final eventNavigationController = Get.find<EventNavigation>();
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
          body: FutureBuilder<List<Events>>(
        future: ApiRequests().allEvents(''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/dummy_splash.png",
                      ),
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        VisibilityDetector(
                          key: ObjectKey(flickMultiManager),
                          onVisibilityChanged: (visibility) {
                            if (visibility.visibleFraction == 0 && mounted) {
                              flickMultiManager.pause();
                            }
                          },
                          child: PageView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Events event = snapshot.data![index];
                              return Stack(
                                children: [
                                  Container(
                                    //   height: 800,
                                    //   margin: const EdgeInsets.all(2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FlickMultiPlayer(
                                        url: event.media[0].url,
                                        flickMultiManager: flickMultiManager,
                                        image: 'assets/images/loading.gif',
                                        type: event.media[0].type,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 100,
                                    child: Container(
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 130,
                                        ),
                                        // BoxShadow(
                                        //   color: Colors.black,
                                        //   blurRadius: 20,
                                        // )
                                      ]),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(
                                                  'assets/images/announcement.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                event.category.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            event.description,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              LoadingManager.dummyLoading();
                                              eventNavigationController
                                                  .navigatingFromSplash(true);
                                              Get.to(() => EventDescription(
                                                  event: event));
                                            },
                                            child: Text(
                                              '\nView details',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                        // Positioned.fill(
                        //   child: CarouselSlider(
                        //     options: CarouselOptions(
                        //         viewportFraction: 1, aspectRatio: 25 / 10),
                        //     items: snapshot.data!.map((i) {
                        //       return Builder(
                        //         builder: (BuildContext context) {
                        //           return GestureDetector(
                        //             onTap: () {
                        //               LoadingManager.dummyLoading();
                        //               eventNavigationController
                        //                   .navigatingFromSplash(true);
                        //               Get.to(() => EventDescription(event: i));
                        //             },
                        //             child: Stack(
                        //               children: [
                        //                 Container(
                        //                     width: 310,
                        //                     decoration: BoxDecoration(
                        //                         color: Colors.black),
                        //                     margin: EdgeInsets.symmetric(
                        //                         horizontal: 5.0),
                        //                     child: i.media[0].type == 'image'
                        //                         ? Image.network(
                        //                             i.media[0].url,
                        //                             fit: BoxFit.cover,
                        //                           )
                        //                         : FeedPlayer(
                        //                             url: i.media[0].url,
                        //                           )),
                        //               ],
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: SafeArea(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => CheckLogin());
                        },
                        child: Text("skip")),
                  ),
                ),
              ],
            );
          }
          return Center();
        },
      )),
    );
  }
}

import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/feed_player.dart';
import 'package:alibtisam/features/signup&login/presentation/checkLogin/check_login.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/presentation/event_desciption.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

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
  }
  removeSplash() async {
    await Future.delayed(Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

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
                        Positioned.fill(
                          child: CarouselSlider(
                            options: CarouselOptions(
                                viewportFraction: 1, aspectRatio: 25 / 10),
                            items: snapshot.data!.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      LoadingManager.dummyLoading();
                                      eventNavigationController
                                          .navigatingFromSplash(true);
                                      Get.to(() => EventDescription(event: i));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                            width: 310,
                                            decoration: BoxDecoration(
                                                color: Colors.black),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: i.media[0].type == 'image'
                                                ? Image.network(
                                                    i.media[0].url,
                                                    fit: BoxFit.cover,
                                                  )
                                                : FeedPlayer(
                                                    url: i.media[0].url,
                                                  )),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => CheckLogin());
                          },
                          child: Text("skip")),
                    ))
              ],
            );
          }
          return Center();
        },
      )),
    );
  }
}
